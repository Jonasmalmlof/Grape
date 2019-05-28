unit DirectX7Unit;

interface

{$APPTYPE GUI}
{$I DirectX.inc}

uses
  Windows, Messages, SysUtils, Variants,    Classes, Graphics, Controls,
  Forms,   Dialogs,  ExtCtrls,Menus,   StdCtrls, ComCtrls,
  ImgList, Clipbrd,  StrUtils, Math,

  Direct3D9, D3DX9,             // Direct X

  T3dfxTypesUnit,               // Generic Types
  T3dfxGenUnit,                 // Base Class
  T3dfxUnit,                    // Device

  // Frames used only in this Module

  TFrame1Unit,                  // Main Frame
  TSceenFrameUnit,              // Scene Frame
  TObjectListFrameUnit,         // Object List Frame
  ObjectFrameUnit,              // Object Property FRame
  TTRackFrameUnit,              // Debugging FRame
  TLogFrameUnit,                // Log Frame

  // Processes used only in this Module
  
  T3dfxProcBaseUnit,            // Process List
  T3dfxProcUpdateRenderGuiUnit, // Update Gui Process
  T3dfxProcAppInitUnit,         // Init Application Process
  T3dfxProcMainShutDownUnit,    // ShutDown Process
  T3dfxProcKeysUnit;            // Key Process

(*------------------------------------------------------------------------------

  Classes.txt
  ClassHier.txt
  Modules.txt
  Document.txt
  Symbols.txt

  //----------------------------------------------------------------------------
  // Window Stuff

  Windows.pas
  Messages.pas

  //----------------------------------------------------------------------------
  // Generic

  T3dfxGeometryUnit         Math Functions
  TMyStrUnit                String Functions
  TAverageUnit,             Average Sum
  T3dfxGuiUnit              User Interface
  T3dfxObjectFileUnit       Load/Save Objects
  TMyTextFileUnit           Basic Files
  TPropNodeUnit             Object Properties

  //----------------------------------------------------------------------------
  // Object Lists

  T3dfxObjectListBaseUnit    Base List
  T3dfxObjectListUnit        Orphan Objects List
  T3dfxObjectChildListUnit   Base Object Childrens
  T3dfxCompTypeListUnit      Component Type List

  //----------------------------------------------------------------------------
  // Rendering

  T3dfxRendererUnit
  T3dfxExtentUnit

  //----------------------------------------------------------------------------
  // Actions

  T3dfxActionBaseUnit
  TMyActionUnit
  TMySettingsUnit

  //----------------------------------------------------------------------------
  // Light Management

  T3dfxLightUnit
  T3dfxLightListUnit
  T3dfxLightSpotUnit
  T3dfxLightPointUnit

  T3dfxLightBulbUnit
  T3dfxSpotLightUnit

  //----------------------------------------------------------------------------
  // Eye Management

  T3dfxEyeUnit

  //----------------------------------------------------------------------------
  // Scenes

  T3dfxSceenUnit
  T3dfxSceenAllUnit
  T3dfxSceenRoomsUnit
  T3dfxSceenShipsUnit

  //----------------------------------------------------------------------------
  // Basic Objects and their Vertex Lists & Buffers

  T3dfxGenUnit            Base Class (T3dfxBase)
  T3dfxVertexBufferUnit   Base for Vertex Buffers
  T3dfxVertexUnit         Base for Vertex List

  // PointLists

  T3dfxPointListUnit      T3dfxVbPointListUnit
  T3dfxGalaxUnit          T3dfxVbGalaxUnit

  // LineList and Line Stripes

  T3dfxLineListUnit       T3dfxVbLineListUnit
  T3dfxLineUnit

  // Triangle Stripes Objects

  T3dfxTriStripeUnit      T3dfxVbTriStripeUnit
  T3dfxRectUnit           T3dfxVbRectNormalUnit   / T3dfxVbRectTextureUnit
  T3dfxCubeUnit           T3dfxVbCubeNormalUnit   / T3dfxVbCubeTextureUnit
  T3dfxTubeUnit           T3dfxVbTubeNormalUnit   / T3dfxVbTubeTextureUnit
  T3dfxGlobeUnit          T3dfxVbSphereNormalUnit / T3dfxVbSphereTextureUnit

  T3dfxTriEditUnit        T3dfxVbNormalsUnit / T3dfxVbPositionsUnit

  //  Basic Container without any primitives

  T3dfxContainerUnit      

  // Mesh Type Objects

  T3dfxMeshUnit           Base Mesh class
  T3dfxMeshFileUnit       Mesh from File
  T3dfxMeshTextUnit       Mesh from Text

  // Component Object

  T3dfxCompTypeUnit       Component Type
  T3dfxCompInstUnit       Component Instance

  // Special Objects with Class Vertex Buffers

  T3dfxBoardUnit          T3dfxVbBoardUnit
  T3dfxArrowUnit          T3dfxVbArrowUnit
  T3dfxBulletUnit         T3dfxVbBulletUnit
  T3dfxShockWaveUnit      T3dfxVbShockWaveUnit
  T3dfxScrapsUnit         T3dfxVbScrapsUnit
  T3dfxRocketUnit         T3dfxVbRocketUnit
  T3dfxGridUnit           T3dfxVbGridUnit

  // Special objects for User Interface only

  T3dfxWorldUnit              T3dfxVbWorldUnit
  T3dfxEyeViewUnit            T3dfxVbLookAtUnit
  T3dfxScreenLineUnit         T3dfxVbRayUnit
  T3dfxExtentBoxSimpleUnit    T3dfxVbExtentBoxSimpleUnit

  //----------------------------------------------------------------------------
  // Select User Interface
  
  TMyColorPickUnit      Select a Color
  TMyCompPickUnit       Select a Component
  TMyTexturePickUnit    Select a Texture
  TMyMeshPickUnit       Select a Mesh
  TMyFontPickUnit       Select a Font
  TMyPickFontDlgUnit
  TMyPickFolderUnit     Select a Folder
  TMySaveObjectAsUnit   Save an Object As
  TMySaveSceneAsUnit    Save a Scene As

  TMyClassesUnit         My Class Definitions
*)

//------------------------------------------------------------------------------
// Form Used
//------------------------------------------------------------------------------
type
  TGrapeMain = class(TForm)
    Frame11: TFrame1;
    InfoPanel: TPanel;
    MenuPort: TPopupMenu;
    PanelTop: TPanel;
    FsbInfo: TLabel;
    EyeLabel: TLabel;
    TRackFrame1: TTRackFrame;
    Splitter1: TPanel;
    Splitter2: TPanel;
    ObjectListFrame1: TObjectListFrame;
    SceenFrame1: TSceenFrame;
    LogFrame1: TLogFrame;
    MenuImages: TImageList;
    ObjectFrame1: TObjectFrame;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuExitClick(Sender: TObject);
    procedure InfoPanelResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuPortPopup(Sender: TObject);
    procedure SetTrackingOnOff(Sender: TObject);
    procedure Splitter1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    //--------------------------------------------------------------------------
    // Forms attributes

    //--------------------------------------------------------------------------
    // Timer for Startup and Rendering

    objTimer : TTimer;

    //--------------------------------------------------------------------------
    // Processes

    objProcesses    : T3dfxProcList;
    objProcInit     : T3dfxProcAppInit;
    objProcTiming   : T3dfxProcUpdateRenderGui;
    objProcShutDown : T3dfxProcMainShutDown;
    objProcKeys     : T3dfxProcKeys;

    //--------------------------------------------------------------------------
    // Resizing

    objSplitter1Use  : boolean;
    objSplitter1Down : boolean;
    objSplitter1Last : integer;

    objSplitter2Use  : boolean;
    objSplitter2Down : boolean;
    objSplitter2Last : integer;

    //--------------------------------------------------------------------------
    // Key Commands

    objKeyDown : boolean; // Key is already pressed down

    //--------------------------------------------------------------------------
    // Form Internal Methods
    //--------------------------------------------------------------------------

    // Start the Application Callback

    procedure MainLoop(Sender: TObject);

    // Startup and Render Timer Callback

    procedure RenderTimer(Sender: TObject);

    // Message Loop

    procedure MyOnMessage (var Msg: TMsg; var Handled: Boolean);

    // Initialize resizing of Form Controls

    procedure ResizeInit;   // Resize Init

    // Internal Methods

    procedure SetFontProp;      // Set Font Properties
    procedure LoadCursors;      // Load Predefined Cursors
    procedure SetWindowPos;     // Set Window position and Size

    // Property Methods

    procedure SetEyePos (const Value : TD3DXVector3);
    procedure SetFps    (const Value : integer);
    function  GetOptOn : boolean ;

    function  GetViewPortFocus   : boolean;
    function  GetObjectListFocus : boolean;

  public

    // Shutdown Application

    procedure StartUp;
    procedure ShutDown;

    //--------------------------------------------------------------------------
    // Panel Top

    procedure ResizeInt;                            // Resize all Controls


    //--------------------------------------------------------------------------
    // Sceen Property Frame

    // Refresh the properties of the current Scene

    procedure ScenePropRefresh;

    //--------------------------------------------------------------------------
    // Object List Frame

    procedure ObjectListRefresh;
    procedure ObjectListSelect (const pObj : T3dfxBase);

    //--------------------------------------------------------------------------
    // Object Property Frame

    procedure ObjectPropSelect (const pObj : T3dfxBase);

    //--------------------------------------------------------------------------
    // Tracking View

    procedure ShowTracking;

    //--------------------------------------------------------------------------
    // Optimization Debug Window

    procedure OptRefresh;

    procedure OptUpdateFps(
                const Fps : integer);

    procedure OptUpdateCount(
                const FrustumCount   : integer;
                const OcclusionCount : integer;
                const TotalCount     : integer);

    procedure OptUpdateTiming(
                const MoveTime   : single;
                const RenderTime : single;
                const WaitTime   : single;
                const TotalTime  : single);

    procedure OptUpdateTimingDetails(
                const FrustumTime   : single;
                const OcclAreaTime  : single;
                const OcclHideTime  : single;
                const RenderTime    : single;
                const PresentTime   : single);

    //--------------------------------------------------------------------------
    // Log View

    procedure LogWin (const sLine : string);

    //--------------------------------------------------------------------------
    // Frame1 forwarding

    procedure CopyToClipBoard;
    procedure PopViewMenu(const Pos : TPoint);

    //--------------------------------------------------------------------------
    // Properties

    property pEyePos : TD3DXVector3             write SetEyePos;
    property pFps    : integer                  write SetFps;
    property pOptOn  : boolean read GetOptOn;

    property pViewFRame : TFrame1 read FRame11;

    property pViewPortFocus   : boolean read GetViewPortFocus;
    property pObjectListFocus : boolean read GetObjectListFocus;

  end;

var
  GrapeMain : TGrapeMain;

implementation
{$R *.dfm}

uses
  T3dfxGeometryUnit,  // Math Functions
  TMyStrUnit,         // String Class
  TMySettingsUnit,    // Application Settings
  T3dfxGuiUnit,       // User Interface
  T3dfxSceenUnit,     // Cur Scene
  TMyActionUnit,      // Action / Menus
  TMyClassesUnit;     // Class Definitions

const
  Prf       = 'Window';
  PrfLeft   = 'Left';
  PrfWdt    = 'Width';
  PrfTop    = 'Top';
  PrfHgt    = 'Height';
  PrfTxtWdt = 'TxtWdt';

  PrfSceenOn       = 'SceenOn';
  PrfObjectListOn  = 'ObjListOn';
  PrfObjectListHgt = 'ObjListHgt';
  PrfObjectOn      = 'ObjOn';
  PrfObjectHgt     = 'ObjHgt';
  PrfLightsOn      = 'LightsOn';
  PrfTrackOn       = 'TrackingOn';
  PrfLogOn         = 'LogOn';
  PrfHint          = 'Hint';

  SplitterHgt = 4;

//------------------------------------------------------------------------------
//
//                         WATCH IT - ITS THE MESSAGE PUMP
//
//------------------------------------------------------------------------------
procedure TGrapeMain.MyOnMessage (var Msg: TMsg; var Handled: Boolean);
begin

  case Msg.message of

    // Texture Node is Highlighted

    WM_HIGHLITETNODE :
      begin
        Frame11.pHighLightNode := Msg.wParam;
        Handled := true;
      end;

    // The Main Window needs resizing, some Property Windows has changed

    WM_RESIZEMAIN :
      begin
        LogToFile('WM_RESIZEMAIN');
        self.ResizeInt;
        Handled := true;
      end;

    // Object List FRame has changed selection

    WM_OBJECTLISTSELECT :
      begin
        obj3dfx.pSelected := TObject(Msg.wParam) as T3dfxBase;
        GrapeMain.ObjectPropSelect(TObject(Msg.wParam) as T3dfxBase);
        Handled := true;
      end;

    WM_VIEWPORTPOPMENU :
      begin
        self.PopViewMenu(Mouse.CursorPos);
        Handled := true;
      end;

  end;
end;
//------------------------------------------------------------------------------
//
//                             CREATE AND INITIALIZATIONS
//
//------------------------------------------------------------------------------
//  Create The Main Form. Starts everything
//------------------------------------------------------------------------------
procedure TGrapeMain.FormCreate(Sender: TObject);
begin
  //----------------------------------------------------------------------------
  // Create all Process Objects
  //----------------------------------------------------------------------------

  objProcesses := T3dfxProcList.Create;

  // Application Initiate Process

  objProcInit  := T3dfxProcAppInit.Create;
  objProcesses.AddProc(objProcInit);

  // User Interface Render Process

  objProcTiming := T3dfxProcUpdateRenderGui.Create;
  objProcesses.AddProc(objProcTiming);

  // Application ShutDown Process

  objProcShutDown := T3dfxProcMainShutDown.Create;
  objProcesses.AddProc(objProcShutDown);

  // Key and Wheel Process

  objProcKeys := T3dfxProcKeys.Create;
  objProcesses.AddProc(objProcKeys);

  // Start Initialize Process

  objProcInit.Perform;

end;
//------------------------------------------------------------------------------
//  Startup Main Form
//------------------------------------------------------------------------------
procedure TGrapeMain.StartUp;
begin
  // Startup Log Frame

  LogFrame1.Startup;

  // Initiate all Local properties

  OnAppClosing          := false;       // Not Closing
  Application.OnMessage := MyOnMessage; // Key Manage
  objKeyDown            := false;       // Key is not down
  self.KeyPreview       := true;        // Preview all Keys

  // Set the Global Variables

  SetFontProp;  // Compute Font Properties
  LoadCursors;  // Load all Cursors
  SetWindowPos; // Set Main Windows Position and Size

  // Set Frames On or Off

  SceenFrame1.pOn       := AppSettings.pSceneOn;
  ObjectListFrame1.pOn  := AppSettings.pListOn;
  ObjectListFrame1.pHgt := AppSettings.pListHeigth;
  ObjectFrame1.pOn      := AppSettings.pPropOn;
  ObjectFrame1.pHgt     := AppSettings.pPropHeight;
  TrackFrame1.pOn       := AppSettings.pTrackingOn;
  LogFrame1.pOn         := AppSettings.pLogOn;

  // Resize All Controls

  //ResizeInit;
  ResizeInt;

  // Initate some Frames

  FRame11.Startup;
  FRame11.pTextureWdt := AppSettings.pTextureWdt;

  // Create the Startup and Rendering Timer

  objTimer := TTimer.Create(Application);
  objTimer.Enabled  := true;
  objTimer.Interval := 10;
  objTimer.OnTimer  := MainLoop;

end;
//------------------------------------------------------------------------------
//
//                                 MAIN LOOP
//
//------------------------------------------------------------------------------
// Startup Timer Fired, Render until Closing
//------------------------------------------------------------------------------
procedure TGrapeMain.MainLoop(Sender: TObject);
var
  Ind : integer;
begin

  // Disable the Timer and reset OnTimer event call

  objTimer.Enabled  := false;
  objTimer.OnTimer  := RenderTimer;
  objTimer.Interval := 1;

  // Perform Initiation number 2

  objProcInit.Perform2;

  // Initiate Engines
  (*
  obj3dfx := T3dfx.Create(Frame11, FRame11.ClientRect);

  // Set the Scene from last Scene Name

  SceneLoadFromFile(AppSettings.pSceneFile);
  *)
  // Set Scene dependent properties

  SceenFrame1.SceneFrameSetup;
  ObjectFrame1.Setup(ObjectListFrame1.ObjectImages);

  Log('T3dfxSize ' + ToStr(T3dfxBase.InstanceSize));
  
  Log('------------------------------ INITATED -----------------------------');

  // Perform main loop until closing Application

  Ind := 0;
  while (not OnAppClosing) do
    begin
      obj3dfx.PerformRenderFrame;

      // Start the Render Timer to get rendering while Processing Messages

      objTimer.Enabled := true;

      // Process any Messages (this can take time, menus etc)

      Inc(Ind);
      if Ind > 10 then
        begin
          Ind := 0;
          Application.ProcessMessages;
        end;
        
      // Disable the Render Timer

      objTimer.Enabled := false;
    end;

  // Start Application ShutDown Process

  objProcShutDown.Perform;

  // Close My Processes

  objProcesses.Free;

end;
//------------------------------------------------------------------------------
// Render Timer will trigger on long ProcessMessages
//------------------------------------------------------------------------------
procedure TGrapeMain.RenderTimer(Sender: TObject);
begin
  // Disable Render Timer

  objTimer.Enabled := false;

  // Run one Frame Loop

  obj3dfx.PerformRenderFrame;

  // Restart timer if not Application is closing

  if (not OnAppClosing) then objTimer.Enabled := true;
end;
//------------------------------------------------------------------------------
//
//                               CLOSE AND DESTROY
//
//------------------------------------------------------------------------------
// Application Closed from Close Button
//------------------------------------------------------------------------------
procedure TGrapeMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  objTimer.Enabled := false;
  OnAppClosing     := true;
end;
//------------------------------------------------------------------------------
// Application Closed from Menu
//------------------------------------------------------------------------------
procedure TGrapeMain.MenuExitClick(Sender: TObject);
begin
  objTimer.Enabled := false;
  OnAppClosing     := true;
end;
//------------------------------------------------------------------------------
// Shut Down the Application (called from Main Loop)
//------------------------------------------------------------------------------
procedure TGrapeMain.ShutDown;
begin

  //----------------------------------------------------------------------------
  // Update Ini Settings

  // Main Windows Setting

  AppSettings.pWinLeft   := self.Left;
  AppSettings.pWinWidth  := self.Width;
  AppSettings.pWinTop    := self.Top;
  AppSettings.pWinHeight := self.Height;

  // Shutdown all Frames

  TrackFrame1.ShutDown;           // Tracking Debug FRame
  ObjectListFrame1.ShutDown;      // ObjectList Frame
  SceenFrame1.SceneFrameShutdown; // Scene Frame
  ObjectFrame1.Shutdown;          // Obejct Properties Frame
  LogFrame1.ShutDown;             // Log Frame ShutDown
  Frame11.ShutDown;               // Render Frame ShutDown
end;
//------------------------------------------------------------------------------
//
//                              USER INTERFACE
//
//------------------------------------------------------------------------------
// Update FPS (Frames Per Second)
//------------------------------------------------------------------------------
procedure TGrapeMain.SetFps(const Value : integer);
begin
  FsbInfo.Caption := 'FPS ' + IntToStr(Value);
end;
//------------------------------------------------------------------------------
// Has ViewPort Focus
//------------------------------------------------------------------------------
function TGrapeMain.GetViewPortFocus   : boolean;
begin
  result := Frame11.pHasFocus;
end;
//------------------------------------------------------------------------------
// Has Object List Focus
//------------------------------------------------------------------------------
function TGrapeMain.GetObjectListFocus : boolean;
begin
  result := ObjectListFrame1.pHasFocus;
end;
//------------------------------------------------------------------------------
//
//                             INPUT MANAGEMENT
//
//------------------------------------------------------------------------------
//  Wheel Up/Down Events
//------------------------------------------------------------------------------
procedure TGrapeMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  objProcKeys.MouseWheel(
                (ssShift in Shift), // Shift is held down
                (ssCtrl	 in Shift), // Control is held down
                (ssAlt	 in Shift), // Alt is held down
                (WheelDelta > 0),   // True if Wheel Up, not Down
                Handled);
end;
//------------------------------------------------------------------------------
// Key Down Event
//------------------------------------------------------------------------------
procedure TGrapeMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  objProcKeys.KeyDown(
                (ssShift in Shift), // Shift is held down
                (ssCtrl	 in Shift), // Control is held down
                (ssAlt	 in Shift), // Alt is held down
                Key);               // Key pressed
end;
//------------------------------------------------------------------------------
// Key Up Event
//------------------------------------------------------------------------------
procedure TGrapeMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  objProcKeys.KeyUp(
                (ssShift in Shift), // Shift is held down
                (ssCtrl	 in Shift), // Control is held down
                (ssAlt	 in Shift), // Alt is held down
                Key);               // Key released
end;
//------------------------------------------------------------------------------
//
//                                  MENU COMMANDS
//
//------------------------------------------------------------------------------
// ViewPort Menu Popup
//------------------------------------------------------------------------------
procedure TGrapeMain.MenuPortPopup(Sender: TObject);
begin
  MenuPort.Items.Clear;
  MyActions.LoadPopupMenu(TMyActionObjInsert,MenuPort);
  MyActions.LoadPopupMenu(TMyActionView,MenuPort);
end;
//------------------------------------------------------------------------------
//
//                               MAIN VIEW FRAME
//
//------------------------------------------------------------------------------
//  Forward Copy To Clipboard Command
//------------------------------------------------------------------------------
procedure TGrapeMain.CopyToClipBoard;
begin
  Frame11.CopyToClipBoard;
end;
//------------------------------------------------------------------------------
//  Pop Main Window Menu
//------------------------------------------------------------------------------
procedure TGrapeMain.PopViewMenu(const Pos : TPoint);
begin
  self.MenuPort.Popup(Pos.x,Pos.y);
end;
//------------------------------------------------------------------------------
//
//                              SCENE PROPERTY FRAME
//
//------------------------------------------------------------------------------
// Refresh any changed Scene Properties
//------------------------------------------------------------------------------
procedure TGrapeMain.ScenePropRefresh;
begin
  SceenFrame1.ScenePropRefresh;
end;
//------------------------------------------------------------------------------
//
//                              OBEJCTLIST WINDOW
//
//------------------------------------------------------------------------------
// Refresh Object List
//------------------------------------------------------------------------------
procedure TGrapeMain.ObjectListRefresh;
begin
  ObjectListFrame1.ObjectsPing;
end;
//------------------------------------------------------------------------------
// Select Object in Object List
//------------------------------------------------------------------------------
procedure TGrapeMain.ObjectListSelect (const pObj : T3dfxBase);
begin
  ObjectListFrame1.pObj := pObj;
end;
//------------------------------------------------------------------------------
//
//                              OBEJCT PROPERTY WINDOW
//
//------------------------------------------------------------------------------
// Select Object in Object Property Frame
//------------------------------------------------------------------------------
procedure TGrapeMain.ObjectPropSelect (const pObj : T3dfxBase);
begin
  ObjectFrame1.pObj := pObj;
end;
//------------------------------------------------------------------------------
//
//                                 OBJECT TRACE WINDOW
//
//------------------------------------------------------------------------------
// Toggle Tracking on/off
//------------------------------------------------------------------------------
procedure TGrapeMain.SetTrackingOnOff(Sender: TObject);
begin
  //objTrackingOn := not objTrackingOn;
end;
//------------------------------------------------------------------------------
// Draw an X,Y Position
//------------------------------------------------------------------------------
procedure TGrapeMain.ShowTracking();
begin
  TrackFrame1.TrackRefresh;
end;
//------------------------------------------------------------------------------
//
//                              OPTIMIZATION WINDOW
//
//------------------------------------------------------------------------------
// Update Optimi
//------------------------------------------------------------------------------
procedure TGrapeMain.OptRefresh;
begin
  objProcTiming.Perform;
end;
//------------------------------------------------------------------------------
// Is Optimization On
//------------------------------------------------------------------------------
function TGrapeMain.GetOptOn:boolean;
begin
  result := self.TRackFrame1.pOptOn;
end;
//------------------------------------------------------------------------------
// Is Optimization On
//------------------------------------------------------------------------------
procedure TGrapeMain.OptUpdateFps(const Fps : integer);
begin
  TrackFrame1.OptUpdateFps(Fps);
end;
//------------------------------------------------------------------------------
// Show Eye Coordinates. Called by Eye object or other Object
//------------------------------------------------------------------------------
procedure TGrapeMain.SetEyePos(const Value : TD3DXVector3);
begin
  EyeLabel.Caption := 'Eye Pos ' + ToStr(Value);
end;
//------------------------------------------------------------------------------
// Is Optimization On
//------------------------------------------------------------------------------
procedure TGrapeMain.OptUpdateCount(
                const FrustumCount   : integer;
                const OcclusionCount : integer;
                const TotalCount     : integer);
begin
  TrackFrame1.OptUpdateCount(FrustumCount,OcclusionCount,TotalCount);
end;
//------------------------------------------------------------------------------
// Is Optimization On
//------------------------------------------------------------------------------
procedure TGrapeMain.OptUpdateTiming(
                const MoveTime   : single;
                const RenderTime : single;
                const WaitTime   : single;
                const TotalTime  : single);
begin
  TrackFrame1.OptUpdateTiming(MoveTime,RenderTime,WaitTime,TotalTime);
end;
//------------------------------------------------------------------------------
// Is Optimization On
//------------------------------------------------------------------------------
procedure TGrapeMain.OptUpdateTimingDetails(
                const FrustumTime   : single;
                const OcclAreaTime  : single;
                const OcclHideTime  : single;
                const RenderTime    : single;
                const PresentTime   : single);
begin
  TRackFRame1.OptUpdateTimingDetail(
      FrustumTime,
      OcclAreaTime,
      OcclHideTime,
      RenderTime,
      PresentTime);
end;
//------------------------------------------------------------------------------
//
//                                 LOG WINDOW
//
//------------------------------------------------------------------------------
// Log
//------------------------------------------------------------------------------
procedure TGrapeMain.LogWin(const sLine : string);
begin
  if (LogFrame1 <> nil) then LogFrame1.Log(sLIne);
end;
//------------------------------------------------------------------------------
//
//                                   RESIZING
//
//------------------------------------------------------------------------------
// Window Is Resizing
//------------------------------------------------------------------------------
procedure TGrapeMain.FormResize(Sender: TObject);
begin
  ;
end;
//------------------------------------------------------------------------------
// Set Font Data
//------------------------------------------------------------------------------
procedure TGrapeMain.SetFontProp;
begin
  FsbInfo.Caption := 'Texture :';
  TextHgt  := FsbInfo.Height + Brd*2;
  LabelWdt := FsbInfo.Width + Brd * 2;
  FsbInfo.Caption := 'X';
  CharWdt  := FsbInfo.Width;
  FsbInfo.Caption := 'Object:';
end; 
//------------------------------------------------------------------------------
//  Create The Main Form. Starts everything
//------------------------------------------------------------------------------
procedure TGrapeMain.LoadCursors;
begin
  // Load Cursors

  MyLoadCursor(crMyMovXyz, 'MOVXYZ');
  MyLoadCursor(crMyMovX,   'MOVX');
  MyLoadCursor(crMyMovY,   'MOVY');
  MyLoadCursor(crMyMovZ,   'MOVZ');

  MyLoadCursor(crMyRotXyz, 'ROTXYZ');
  MyLoadCursor(crMyRotX,   'ROTX');
  MyLoadCursor(crMyRotY,   'ROTY');
  MyLoadCursor(crMyRotZ,   'ROTZ');

  MyLoadCursor(crMySclXyz, 'SCLXYZ');
  MyLoadCursor(crMySclX,   'SCLX');
  MyLoadCursor(crMySclY,   'SCLY');
  MyLoadCursor(crMySclZ,   'SCLZ');

  MyLoadCursor(crAddPnt,   'ADDPOINT');
  MyLoadCursor(crMovPnt,   'MOVPOINT');
  MyLoadCursor(crDelPnt,   'DELPOINT');

end; 
//------------------------------------------------------------------------------
// Set Main Window Position
//------------------------------------------------------------------------------
procedure TGrapeMain.SetWindowPos;
begin

  self.SetBounds(AppSettings.pWinLeft, AppSettings.pWinTop,
                 AppSettings.pWinWidth,AppSettings.pWinHeight);

  // Make sure its inside Screen size

  if self.Left < 0 then self.Left := 0;
  if self.Width > screen.Width then self.Width := screen.Width;
  if ((self.Left + self.Width) > (screen.Width)) then self.Left := 0;
  if self.Top < 0 then self.Top := 0;
  if self.Height > screen.Height then self.Height := screen.Height;
  if ((self.Top + self.Height) > (screen.Height)) then self.Top := 0;

end;
//------------------------------------------------------------------------------
// Window Is Resizing
//------------------------------------------------------------------------------
procedure TGrapeMain.InfoPanelResize(Sender: TObject);
begin
  ResizeInit;
  ResizeInt;
end;
//------------------------------------------------------------------------------
// Resize All Controls Initially (Not dynamically adjustable parts)
//------------------------------------------------------------------------------
procedure TGrapeMain.ResizeInit;
begin
  //Log('TGrapeMain.ResizeInit  Internal Begin ' +
  //' Wdt ' + IntToStr(InfoPanel.ClientWidth) +
  //' Hgt ' + IntToStr(InfoPanel.ClientHeight));

  //----------------------------------------------------------------------------
  // Log Frame

  //SetControlWidth(LogFrame1,0,InfoPanel.ClientWidth);
  //LogFrame1.Left   := 0;
  //LogFrame1.Width  := InfoPanel.ClientWidth;
  //Log('TGrapeMain.ResizeInit  Internal 1');

  //----------------------------------------------------------------------------
  // Sceen Frame

  SetControlSize(SceenFrame1, 0, InfoPanel.ClientWidth,
    PanelTop.Left + PanelTop.Height + SplitterHgt,SceenFrame1.Height);
  // SceenFrame1.Left  := 0;
  // SceenFrame1.Width := InfoPanel.ClientWidth;
  // SceenFrame1.Top   := PanelTop.Left + PanelTop.Height + SplitterHgt;
  //Log('TGrapeMain.ResizeInit  Internal 2');

  //----------------------------------------------------------------------------
  // Object List Frame

  SetControlWidth(ObjectListFrame1,0,InfoPanel.ClientWidth);
  //ObjectListFrame1.Left  := 0;
  //ObjectListFrame1.Width := InfoPanel.ClientWidth;
  //Log('TGrapeMain.ResizeInit  Internal 3');

  SetControlSize(Splitter1,0,InfoPanel.ClientWidth,Splitter1.Top,SplitterHgt);
  //Splitter1.Left   := 0;
  //Splitter1.Width  := InfoPanel.ClientWidth;
  //Splitter1.Height := SplitterHgt;
  //Log('TGrapeMain.ResizeInit  Internal 4');

  //----------------------------------------------------------------------------
  // Object Property Frame

  SetControlWidth(ObjectFrame1,0,InfoPanel.ClientWidth);
  //ObjectFrame1.Left  := 0;
  //ObjectFrame1.Width := InfoPanel.ClientWidth;
  //Log('TGrapeMain.ResizeInit  Internal 5');

  SetControlSize(Splitter2,0,InfoPanel.ClientWidth,Splitter2.Top,SplitterHgt);
  //Splitter2.Left   := 0;
  //Splitter2.Width  := InfoPanel.ClientWidth;
  //Splitter2.Height := SplitterHgt;
  //Log('TGrapeMain.ResizeInit  Internal 6');

  //----------------------------------------------------------------------------
  // Tracking Frame

  SetControlWidth(TrackFrame1,0,InfoPanel.ClientWidth);
  //TrackFrame1.Left  := 0;
  //TrackFrame1.Width := InfoPanel.ClientWidth;
  //Log('TGrapeMain.ResizeInit  Internal End');
end;
//------------------------------------------------------------------------------
// Resize All Controls
//------------------------------------------------------------------------------
procedure TGrapeMain.ResizeInt;
var
  NewHgt : integer;
  bDone  : boolean;
begin
  //LogToFile('TGrapeMain.ResizeInt 1');

  bDone := false;

  // There are three Controls that can be resized dynamically

  // 2) If the LogFrame is Open, we use that as slack
  // 3) else if ObjectFRame is Open, we use that as Slack
  // 4) else if ObjectList Frame is Open we use that as Slack
  // 5) Else we just position them as is

  if LogFrame1.pOn then
    begin
      // Log Frame is Open, Use that as Slack
      // Calculate the Height to fill it up

      NewHgt := InfoPanel.ClientHeight  -
                PanelTop.Height         - SplitterHgt -
                SceenFrame1.Height      - SplitterHgt -
                ObjectListFrame1.Height - SplitterHgt -
                ObjectFrame1.Height     - SplitterHgt -
                TrackFrame1.Height      - SplitterHgt;

      // If the height is not atleast two rows there is not enough place, so
      // we need to adjust one of the other Frames

      if (NewHgt < LogFrame1.pMinHgt) then
        begin
          // Set Log Frame at a fixed min Height

          LogFrame1.pHgt := LogFrame1.pMinHgt;

          // We are not done yet
        end
      else
        begin
          // The Slack is taken fully, we are done

          LogFrame1.pHgt := NewHgt;
          bDone := true;
        end;
    end;

  if (not bDone) and ObjectFrame1.pOn then
    begin
      // Object Frame is Open, Use that as Slack
      // Calculate Height to fill it up

      NewHgt := InfoPanel.ClientHeight  -
                PanelTop.Height         - SplitterHgt -
                SceenFrame1.Height      - SplitterHgt -
                ObjectListFrame1.Height - SplitterHgt -
                TrackFrame1.Height      - SplitterHgt -
                LogFrame1.Height        - SplitterHgt;

      // If the height is not atleast two rows there is not enough place, so
      // we need to adjust one of the other Frames

      if (NewHgt < ObjectFrame1.pMinHgt) then
        begin
          // Set Log Frame at a fixed min Height

          ObjectFrame1.pHgt := ObjectFrame1.pMinHgt;

          // We are not done yet
        end
      else
        begin
          // The Slack is taken fully, we are done

          ObjectFrame1.pHgt := NewHgt;
          bDone := true;
        end;
    end;

  // If not all Slack is taken, try Object List as last resort
  
  if (not bDone) and ObjectListFrame1.pOn then
    begin
      // Else if Object List Frame is Open, Use that as Slack
      // Calculate Height to Fill it up
      
      ObjectListFrame1.pHgt :=
                           InfoPanel.ClientHeight -
                           PanelTop.Height         - SplitterHgt -
                           SceenFrame1.Height      - SplitterHgt -
                           ObjectFrame1.Height     - SplitterHgt -
                           TrackFrame1.Height      - SplitterHgt -
                           LogFrame1.Height        - SplitterHgt;

      // If this is negative, were basically fully fucked 
    end
  else
    begin
      // No Frame that can take Slack was Open, we just position them
      // From To Bottom. They should fit into and leav empty space below

    end;

  // Do the adjustment on each Frames and Splitter

  ObjectListFrame1.Top := SceenFrame1.Top + SceenFrame1.Height + SplitterHgt;

  Splitter1.Top    := ObjectListFrame1.Top + ObjectListFrame1.Height;
  ObjectFrame1.Top := Splitter1.Top + Splitter1.Height;
  Splitter2.Top    := ObjectFrame1.Top + ObjectFrame1.Height;
  TrackFrame1.Top  := Splitter2.Top + Splitter2.Height;
  LogFrame1.Top    := TrackFrame1.Top + TrackFrame1.Height + SplitterHgt;

  //----------------------------------------------------------------------------
  // Set Splitters On/Off and their Cursors

  objSplitter1Use := ObjectListFrame1.pOn;
  objSplitter2Use := ObjectFrame1.pOn;

  if objSplitter1Use then
    Splitter1.Cursor := crVSplit
  else
    Splitter1.Cursor := crDefault;

  if objSplitter2Use then
    Splitter2.Cursor := crVSplit
  else
    Splitter2.Cursor := crDefault;

  //LogToFile('TGrapeMain.ResizeInt End');
end;
//------------------------------------------------------------------------------
//  Splitter 1 Mouse Down
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and objSplitter1Use then
    begin
      objSplitter1Down := true;
      objSplitter1Last := Y;
    end;
end;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  dy : integer;
begin
  if (objSplitter1Down) and (ssLeft	in Shift) then
    begin
      dy := (Y-objSplitter2Last);
      objSplitter1Last := Y;

      // 1) User can move up until Object List is an Min Height

      // 2) User can Move Down All Things until Log Frame and ObjectFrame
      //    both are at their Min Heights

      if (ObjectListFrame1.Height <= ObjectListFrame1.pMinHgt) and (dy < 0) then dy := 0;


      if (LogFrame1.Height <= LogFrame1.pMinHgt) and
         (ObjectFrame1.Height <= ObjectFrame1.pMinHgt) and (dy > 0) then dy := 0;

      if (dy <> 0) then
        begin
          ObjectListFrame1.pHgt := ObjectListFrame1.pHgt + dy;
          objSplitter1Last := Y;

          ResizeInt;
        end;
    end;
end;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  objSplitter1Down := false;
end;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and objSplitter2Use then
    begin
      objSplitter2Down := true;
      objSplitter2Last := Y;
    end;
end;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  dy : integer;
begin
  if (objSplitter2Down) and (ssLeft	in Shift) then
    begin
      dy := (Y-objSplitter2Last);
      objSplitter1Last := Y;

      // 1) User can move up unitil Object Property is at Min Height
      // 2) User can Move Down All Things until Log Frame is a Min Hgt

      if (ObjectFrame1.Height <= ObjectFrame1.pMinHgt) and (dy < 0) then dy := 0;
      if (LogFrame1.Height <= LogFrame1.pMinHgt) and (dy > 0) then dy := 0;

      if (dy <> 0) then
        begin
          ObjectFrame1.pHgt := ObjectFrame1.pHgt + dy;

          ResizeInt;
        end;
    end;
end;
//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  objSplitter2Down := false;
end;
//------------------------------------------------------------------------------
//                                    INITIALIZE
//------------------------------------------------------------------------------
initialization

  RegClass(TGrapeMain, 'DirectX7Unit');

end.
