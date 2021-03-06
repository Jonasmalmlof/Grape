unit T3dfxUnit;

//{$DEFINE LOGINIT}
//{$DEFINE LOGSELECT}

interface
uses
  Windows, Controls, Forms, Classes, Contnrs, 

  Direct3D9, D3DX9,     // DirectX

  T3dfxTypesUnit,     // Generic Types
  T3dfxBaseUnit,      // Base Class
  T3dfxViewPortUnit,  // View Port
  TFpsTimerUnit,      // Test Timer
  TGenObjectUnit,     // TGenObject
  T3dfxSceenUnit;     // Scene

const
  psOne = 0;  // Max Precision PointSize
  psNrm = 1;  // Normal PointSize
  psBig = 2;  // Big PointSize

//------------------------------------------------------------------------------
//
//                                MAIN OBJECT
//
//------------------------------------------------------------------------------
//  Main 3dfx Object
//------------------------------------------------------------------------------
{$IFDEF DEFDEBUG}
type T3dfx = class(TGenObject)
{$ELSE}
type T3dfx = class(TObject)
{$ENDIF}
  private
    //--------------------------------------------------------------------------
    // Device Properties
    // The Device is the Main Window/Form that DirectX renders to
    // On the Device a number of ViewPorts are placed that all Events and
    // actual Drawing occur in
    //--------------------------------------------------------------------------

    objDeviceInit : boolean; // The Device is initiated successfully

    // Device Objects and Properties

    objPres : D3DPRESENT_PARAMETERS; // Device Presentation Parameters
    objpD3D : IDirect3D9;            // Used to create the D3D Device
    objForm : TWinControl;           // The Main Form the Device is attached to

    // Pointsizes are set when intitiating Device

    objPntSizeCur : integer;  // Current PointSize

    // Capabilities

    objFogRange : boolean; // Fog Range Capability

    //--------------------------------------------------------------------------
    // ViewPort Data
    // Each ViewPort has a current Scene with draw objects, and a Render Engine
    //--------------------------------------------------------------------------

    objViewPortList : TObjectList;   // List of Current ViewPorts

    // The Current ViewPort is the one the user is working with. Other View
    // ports are just renderered

    objCurViewPort  : T3dfxViewPort; // Current View Port

    //--------------------------------------------------------------------------
    // Internal Methods
    //--------------------------------------------------------------------------

    // Create DIrectX9 object, Set Presentation and Create DirectX device

    function  InitD3D: boolean;

    procedure SetPresParameters;

    // Get / Set Pointsize

    function  GetPntSize              : integer;
    procedure SetPntSize (const Value : integer);

    // Scene

    function  GetViewPort : T3dfxViewPort;

    function  GetScene              : T3dfxSceen;
    procedure SetScene (const Value : T3dfxSceen);

//------------------------------------------------------------------------------
// Publich Methods & Properties
//------------------------------------------------------------------------------
  public
    constructor Create (const Form : TWinControl);

    destructor Destroy(); override;

    // Perform the Rendering Process for all ViewPorts

    procedure PerformRenderFrame; // Called by Main Loop (twice)

    // Manage Mouse Down Events

    procedure MouseDownInput(
                const x,y   : integer;
                const Shift : TShiftState);

    // Manage Mouse Move Events

    function MouseMoveInput (
                const x, y   : integer;  // Screen Position
                const Shift  : TShiftState)
                             : boolean;     // True if used

    // Manage Mouse Up Events

    procedure MouseUpInput(
                const x,y   : integer;
                const Shift : TShiftState);

    // Manage Mouse Double Click Event

    procedure MouseDblClick;

    // Manage Wheel Input Events

    procedure WheelInput (
                const bUp   : boolean;
                const Shift : TShiftState);

    //--------------------------------------------------------------------------
    // Properties
    //--------------------------------------------------------------------------

    property pDeviceInit : boolean read objDeviceInit;

    property pPntSize : integer read GetPntSize write SetPntSize;

    // View Properties

    property pViewPort : T3dfxViewPort read GetViewPort;
    property pCurScene : T3dfxSceen    read GetScene    write SetScene;

end;

//------------------------------------------------------------------------------
// Singleton: obj3dfx is the Represetation of Device
//
//  Owner:          This Module.
//  Created:        At Application Startup
//  Destroyed:      At Application ShutDown
//  Functionality:  Holds the ViewPorts and creates objDev
//  Used:           By objects using ViewPorts
//  Quality:        Its a natural single object
//------------------------------------------------------------------------------
var DevBase : T3dfx;            // Basic Device Object
    objDev  : IDirect3DDevice9; // DirectX Device

implementation

uses
  SysUtils,
  
  T3dfxGeometryUnit,      // Math Functions
  TGenStrUnit,             // String Functions
  TMySettingsUnit,        // Application Settings

  T3dfxLightListUnit,     // Max Lights

  TGenClassesUnit;

//------------------------------------------------------------------------------
//
//                                MAIN OBJECT
//
//------------------------------------------------------------------------------
// DEVICE: Create 3dfx object
//------------------------------------------------------------------------------
Constructor T3dfx.Create(const Form : TWinControl);
begin
  Inherited Create();

{$IFDEF DEFDEBUG}
  LogMemToFile2(self.ClassName + resLogStartUp, AllocMemSize);
{$ENDIF}

  // Device State: Not curently initiated successfully

  objDeviceInit := false;

  objForm := Form;   // Window to Draw on

  objPntSizeCur := -1;

  //----------------------------------------------------------------------------
  // Initiate DirectX
  //----------------------------------------------------------------------------

  if not InitD3D then
    begin
      EXIT;
    end;

  // Device Initiated Sucessfully

  objDeviceInit := true;

  //----------------------------------------------------------------------------
  // VIEWPORT: Create the First ViewPort
  //----------------------------------------------------------------------------

  // Create ViewPort List

  objViewPortList := TObjectList.Create(true);

  // Create the ViewPort and set properties

  objCurViewPort := T3dfxViewPort.Create;
  objViewPortList.Add(objCurViewPort);
  
  objCurViewPort.pViewRect := Rect(0,0, objForm.Width, objForm.Height);
end;
//------------------------------------------------------------------------------
// DEVICE: Set Presentation Parameters for CreateDevice or Device Reset
//------------------------------------------------------------------------------
procedure T3dfx.SetPresParameters;
begin
  // This belong to the Device

  // Set up the structure used to create the D3DDevice. Most parameters are
  // zeroed out. We set Windowed to TRUE, since we want to do D3D in a
  // window, and then set the SwapEffect to "discard", which is the most
  // efficient method of presenting the back buffer to the display.  And
  // we request a back buffer format that matches the current desktop display
  // format.

  FillChar(objPres, SizeOf(objPres), 0);
  objPres.Windowed                   := True;
  objPres.hDeviceWindow              := objForm.Handle;
  objPres.PresentationInterval       := D3DPRESENT_INTERVAL_IMMEDIATE;
  objPres.FullScreen_RefreshRateInHz := 0;

  // Z-Buffer

  objPres.EnableAutoDepthStencil := True;
  objPres.AutoDepthStencilFormat := D3DFMT_D16;      // 16 Bit Z-Buffer
  objPres.BackBufferFormat       := D3DFMT_UNKNOWN;

  // Back Buffer

  objPres.SwapEffect                 := D3DSWAPEFFECT_DISCARD;
  objPres.BackBufferCount            := 1;

  // Set the Same Hight and Width of the Back Buffer as the Form

  objPres.BackBufferHeight := round(objForm.Height * AppSettings.pResolution);
  objPres.BackBufferWidth  := round(objForm.Width  * AppSettings.pResolution);

  objPres.MultiSampleQuality := 0;
  objPres.MultiSampleType    := D3DMULTISAMPLE_NONE;

end;
//------------------------------------------------------------------------------
// DEVICE: Initiate DirectX
//------------------------------------------------------------------------------
function T3dfx.InitD3D: boolean;
var
  pCaps : TD3DCaps9;

{$IFDEF DEFDEBUG}
  pEventQuery : IDirect3DQuery9;
{$ENDIF}
begin
  // This belongs to the Device

  result := true;

  objpD3D := niL;
  objDev  := nil;

  // Create the D3D object, which is needed to create the D3DDevice.

  objpD3D := Direct3DCreate9(D3D_SDK_VERSION);
  if (objpD3D = nil) then
    begin
      Assert(false, 'Direct3DCreate9');
      result := false;
      EXIT;
    end;

  SetPresParameters;

  // Create the Direct3D device. Here we are using the default adapter (most
  // systems only have one, unless they have multiple graphics hardware cards
  // installed) and requesting the HAL (which is saying we want the hardware
  // device rather than a software one).

  // Software vertex processing is specified since we know it will work on 
  // all cards. On cards that support hardware vertex processing, though,
  // we would see a big performance gain by specifying hardware vertex 
  // processing.
  
  // D3DCREATE_HARDWARE_VERTEXPROCESSING
  // D3DCREATE_SOFTWARE_VERTEXPROCESSING
  // D3DCREATE_MIXED_VERTEXPROCESSING

{$IFDEF DEFDEBUG}
  LogToFile('  ' + self.ClassName + '.CreateDevice');
{$ENDIF}

  if Not HRESULTOK(objpD3D.CreateDevice(
                D3DADAPTER_DEFAULT,
                D3DDEVTYPE_HAL,
                objForm.Handle,
                D3DCREATE_HARDWARE_VERTEXPROCESSING,
                @objPres,
                objDev)) then
    begin
      Assert(false, 'Create Device');
      result := false;
      Exit;
    end;

  //----------------------------------------------------------------------------
  // Set Properties depending on Capabilities
  //----------------------------------------------------------------------------

  if HRESULTOK(objDev.GetDeviceCaps(pCaps)) then
    begin
      // Fog Range

      objFogRange := (pCaps.RasterCaps and D3DPRASTERCAPS_FOGRANGE ) > 0;

      // Max number of Lights

      LightList.pMaxAllowed := pCaps.MaxActiveLights;
    end;

  //----------------------------------------------------------------------------
  // Set Properties after Creating Device
  //----------------------------------------------------------------------------

  // Turn on the Z-buffer

  objDev.SetRenderState(D3DRS_ZENABLE, iTrue);

  //----------------------------------------------------------------------------
  // Turn on culling
  // To improve rendering performance, you can cull out (or remove) a primitive
  // that faces away from the camera. For single-sided primitives, this saves
  // rendering time because a back-face is not visible. To enable culling, you
  // need to know the winding order of the vertices (typically counter-
  // clockwise). This example will remove any primitive whose back face is
  // facing forward (given a counter-clockwise winding order): D3DCULL_CCW
  //  objDev.SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
  //  objDev.SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW);

  objDev.SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW);

  //----------------------------------------------------------------------------
  // Turn on Gouraud Shading
  
  objDev.SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);

  // Set Light Default Values

  objDev.SetRenderState(D3DRS_LIGHTING, iTrue);
  objDev.SetRenderState(D3DRS_SPECULARENABLE, iTrue);

  // Set Current PointSize to Max Precision

  self.pPntSize := psOne;

  //----------------------------------------------------------------------------
  // Log Capabilities
  //----------------------------------------------------------------------------

{$IFDEF DEFDEBUG}

  // Get Device Capabilities

  if HRESULTOK(objDev.GetDeviceCaps(pCaps)) then
    begin
      LogToFile('  Capabilities:');
      
      LogToFile(FixLenStrB('  Fog Range', DebugLineWdt) +
        ToStr(boolean((pCaps.RasterCaps and D3DPRASTERCAPS_FOGRANGE ) > 0)));

      // Get Max Number of Lights and tell LightList about it

      LogToFile(FixLenStrB('  Max Lights', DebugLineWdt) +
                            ToStr(pCaps.MaxActiveLights));

      // Log if Higher Order Primitives is available

      LogToFile(FixLenStrB('  N-Pathces', DebugLineWdt) +
            ToStr(boolean(pCaps.DevCaps and D3DDEVCAPS_NPATCHES)));

      LogToFile(FixLenStrB('  B-splines', DebugLineWdt) +
            ToStr(boolean(pCaps.DevCaps and D3DDEVCAPS_QUINTICRTPATCHES)));

      LogToFile(FixLenStrB('  RT-patches', DebugLineWdt) +
            ToStr(boolean(pCaps.DevCaps and D3DDEVCAPS_RTPATCHES)));

      LogToFile(FixLenStrB('  RT-Pathces Zero', DebugLineWdt) +
            ToStr(boolean(pCaps.DevCaps and D3DDEVCAPS_RTPATCHHANDLEZERO)));

    end;

  Log('Screen Height ' + IntToStr(Screen.Height));
  Log('Screen Width  ' + IntToStr(Screen.Width));

  Log('Want Height ' +
        IntToStr(round(objForm.Width * AppSettings.pResolution)) +
        ' Got ' + IntToStr(objPres.BackBufferHeight));

  Log('Want Width  ' +
        IntToStr(round(objForm.Height * AppSettings.pResolution)) +
        ' Got ' + IntToStr(objPres.BackBufferWidth));

  //----------------------------------------------------------------------------
  // Get Available Memory

  LogToFile(FixLenStrB('  Texture Memory', DebugLineWdt) +
    ToStr(objDev.GetAvailableTextureMem / (1024 * 1024)) + '(Mb)');

  //----------------------------------------------------------------------------
  // Can we issue Queries

  pEventQuery := nil;

  if HRESULTOK(objDev.CreateQuery(D3DQUERYTYPE_EVENT, pEventQuery)) then
    LogToFile(FixLenStrB('  Query Device', DebugLineWdt) + 'Ok')
  else
    LogToFile(FixLenStrB('  Query Device', DebugLineWdt) + 'No');

  LogMemToFile2(self.ClassName + '.InitD3D', AllocMemSize);
{$ENDIF}
end;
//------------------------------------------------------------------------------
// DEVICE: Create
//------------------------------------------------------------------------------
destructor T3dfx.Destroy();
begin

  if (objDev <> nil)  then objDev  := nil;
  if (objpD3D <> nil) then objpD3D := nil;

  // Destroy all ViewPorts and its List
  
  if objViewPortList <> nil then
    objViewPortList.Free;
  
  inherited;
end;
//-----------------------------------------------------------------------------
// DEVICE: Get Device Point Sizes
//-----------------------------------------------------------------------------
function  T3dfx.GetPntSize : integer;
begin
  result := objPntSizeCur;
end;
//-----------------------------------------------------------------------------
// DEVICE: Set Device Point Sizes
//-----------------------------------------------------------------------------
procedure T3dfx.SetPntSize (const Value : integer);
var
  ps : single;
begin
  // Used when rendering Points, either T3dfxPointList objects
  // or Bounding Boxes, Hit Points on lines etc.

  if (objPntSizeCur <> Value) then
    begin
      objPntSizeCur := Value;

      objDev.SetRenderState(D3DRS_POINTSCALEENABLE, iFalse);

      ps := 1.0;

      case objPntSizeCur of
        psOne : ps :=  1.0;
        psNrm : ps :=  9  * AppSettings.pResolution;
        psBig : ps := 13  * AppSettings.pResolution;
      end;

      objDev.SetRenderState(D3DRS_POINTSIZE, ToDWord(ps));
    end;
end;
//------------------------------------------------------------------------------
//
//                                    VIEWPORT
//
//------------------------------------------------------------------------------
// VIEWPORT: Get Current Scene
//------------------------------------------------------------------------------
function T3dfx.GetScene:T3dfxSceen;
begin
  result := nil;
  if (objCurViewPort <> nil) then
    result := objCurViewPort.pScene;
end;
//-----------------------------------------------------------------------------
// Reset all things for a New Current Scene
//-----------------------------------------------------------------------------
procedure T3dfx.SetScene(const Value : T3dfxSceen);
begin
  if (objCurViewPort <> nil) then objCurViewPort.pScene := Value;
end;
//------------------------------------------------------------------------------
// VIEWPORT: Get Current Scene
//------------------------------------------------------------------------------
function T3dfx.GetViewPort:T3dfxViewPort;
begin
  result := objCurViewPort;
end;
//-----------------------------------------------------------------------------
// Perform The Rendering Process for one FRame
//-----------------------------------------------------------------------------
procedure T3dfx.PerformRenderFrame;
var
  Ind : integer;
begin
  // Render all ViewPorts

  if (objViewPortList.Count > 0) then
    for Ind := 0 to objViewPortList.Count - 1 do
      T3dfxViewPort(objViewPortList[Ind]).PerformRenderFrame;
end;
//-----------------------------------------------------------------------------
// Event: Mouse Down from ViewPort Window
//-----------------------------------------------------------------------------
procedure T3dfx.MouseDownInput(const x,y   : integer;
                               const Shift : TShiftState);
begin
  if (objCurViewPort <> nil) then objCurViewPort.MouseDownInput(x, y, Shift);
end;
//-----------------------------------------------------------------------------
// Event: Mouse Move from ViewPort Window
//-----------------------------------------------------------------------------
function T3dfx.MouseMoveInput (
                const x, y   : integer;       // Screen Position
                const Shift  : TShiftState)   // Shift
                             : boolean;       // True if used
begin
  result := false;
  
  if (objCurViewPort <> nil) then
    result := objCurViewPort.MouseMoveInput(x, y, Shift);
end;
//-----------------------------------------------------------------------------
// Event: Mouse Up from ViewPort Window
//-----------------------------------------------------------------------------
procedure T3dfx.MouseUpInput(const x,y   : integer;
                             const Shift : TShiftState);
begin
  if (objCurViewPort <> nil) then objCurViewPort.MouseUpInput(x, y, Shift);
end;
//-----------------------------------------------------------------------------
// Event: Mouse Double Click
//-----------------------------------------------------------------------------
procedure T3dfx.MouseDblClick;
begin
  if (objCurViewPort <> nil) then objCurViewPort.MouseDblClick;
end;
//-----------------------------------------------------------------------------
// Wheel Event Input
//-----------------------------------------------------------------------------
procedure T3dfx.WheelInput (
                const bUp   : boolean;
                const Shift : TShiftState);
begin
  if (objCurViewPort <> nil) then objCurViewPort.WheelInput(bUp, Shift);
end;
//------------------------------------------------------------------------------
//                                    INITIALIZE
//------------------------------------------------------------------------------
initialization

  RegClass(T3dfx,'T3dfxUnit');
  
end.
