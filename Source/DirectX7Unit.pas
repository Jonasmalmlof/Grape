unit DirectX7Unit;

interface

{$APPTYPE GUI}
{$I DirectX.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes,  Graphics, Controls,
  Forms,   Dialogs,  ExtCtrls, Menus,    StdCtrls, ComCtrls, Math,
  ImgList, Clipbrd,  StrUtils, mmsystem,

  Direct3D9, D3DX9,             // Direct X

  T3dfxTypesUnit,               // Generic Types
  T3dfxBaseUnit,                // Sub Base Class
  T3dfxUnit,                    // Device

  // Frames used only in this Module

  TFrame1Unit,                  // Main Frame
  TSceenFrameUnit,              // Scene Frame
  TObjectListFrameUnit,         // Object List Frame
  ObjectFrameUnit,              // Object Property Frame / TSubPropFrameUnit
  TTRackFrameUnit,              // Debugging FRame
  TLogFrameUnit,                // Log Frame             / TTextureFrameUnit

  // Processes used only in this Module

  T3dfxProcBaseUnit,            // Process List
  T3dfxProcAppInitUnit,         // Init Application Process
  T3dfxProcMainShutDownUnit,    // ShutDown Process
  T3dfxProcKeysUnit;            // Key Process

(*------------------------------------------------------------------------------

  DEFINE DEFDEBUG  Use for searching DEBUG Defines

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

  T3dfxTypesUnit            Basic Types
  TGenObjectUnit            TGenObject for debugging
  T3dfxBaseUnit             Base Object
  T3dfxViewBaseUnit         View Added to T3dfxBase
  T3dfxChildBaseUnit        Children/Parent Added to T3dfxViewBase
  T3dfxActionBaseUnit       Actions Added to T3dfxChildBase
  T3dfxPropBaseUnit         Properties Added to T3dfxActionBase

  T3dfxGeometryUnit         Math Functions
  T3dfxStrObjUnit           String Functions
  TResStringUnit,           Resource Strings
  T3dfxGuiUnit              User Interface
  TPropNodeUnit             Object Properties
  T3dfxObjectFileUnit       Load/Save Objects
  TMyMessageFactoryUnit     Message Qeue
  TMySettingsUnit           Application Settings

  TODO:
  TMyFactoryBaseUnit
  TMyMenuUnit
  TMyMessageFactoryUnit
  TTimeZoneDlgUnit

  TGenUnits:
  TGenStrUnit               String Functions
  TGenStrObjUnit            String Class
  TGenLogUnit               Logging
  TGenClassesUnit           Basic Classes
  TGenTextFileUnit          Basic Files
  TGenIniFileUnit           Ini Files
  TGenAverageUnit,          Average Sum
  TGenAssertUnit            Overrides the Assert Handler
  TGenTimeUnit              Time Object
  TGenSleepUnit             Sleep with more precision

  Generic Dialogs:
  TGenOpenDialogUnit        Generic Open File Dialog
  TGenSaveAsDialogUnit      Generic Save As Dialog
  TGenPickFolderUnit        Pick a Folder
  TGenColorPickUnit         Select a Color
  TGenPickFontUnit          Select a Font

  Specific Dialogs:
  T3dfxScenePickUnit        Pick a Scene

  //----------------------------------------------------------------------------
  // ViewPort

  T3dfxUnit                 Device
  T3dfxViewPortUnit         Device ViewPort
  T3dfxRendererUnit         Device Render Engine
  T3dfxSceenUnit            Scene
  T3dfxSceneFactoryUnit     Scene Factory

  //----------------------------------------------------------------------------
  // Actions

  TMyMenuUnit                   Menu Management
  TMyObjActionBaseUnit          Base Class for Object Actions
  TMyObjActionListUnit          Object Action List
  TMyObjActionFactoryUnit       Action Factory

  TMyObjActionFireUnit          Object Fire Action
  TMyObjActionFlashUnit         Flash Light Action
  TMyObjActionMoveUnit          Object Move Action
  TMyObjActionRotateUnit        Object Rotate Action
  TMyObjActionTimeUnit          Object Timer Action
  TMyObjActionScaleUnit         Object Scale Action
  TMyObjActionTrackRandomUnit   Track Random Action
  TMyObjActionTrackObjUnit      Track Object Action

  //----------------------------------------------------------------------------
  // War Actions

  TMyObjActionBaseProcUnit          New Base Process
  TMyObjActionGenShipProcUnit       Ship Base Process

  Sub Actions:

  TMyObjActionMotherShipUnit        Mother Ship Action
  TMyObjActionMotherBombEnemyUnit   Mother is Bombing Enemy
  TMotherLaunchedShipUnit           Ships Launched by Mother Ship
  TMyObjActionDockShipUnit
  TMyObjActionLaunchShipUnit
  TMyObjActionGoHomeUnit            Go Back Home To Mother Action
  TMyObjActionGoEnemyUnit           Go to Enemy Action

  Scout Ship Process:
  TMyObjActionSearchEnemyUnit       Search for Enemy Action

  Bomber Ship Process;
  TMyObjActionBomberToEnemyUnit     Go To Enemy
  TMyObjActionBombEnemyUnit         Go To Enemy and Bomb

  Object Temp Data:

  TTempDataBaseUnit                 Basic Temp Data
  TGenAmmoDataUnit                  Generic Ammunition Data
  TGenBeaconDataUnit                Generic Beacon Data

  TGenShipDataUnit                  Ship Data
  TScoutShipDataUnit                Scout Ship Data
  TBombShipDataUnit                 Bomber Ship Data
  TMotherShipDataUnit               Mother Ship Data

  //----------------------------------------------------------------------------
  // Eye Management

  T3dfxEyeUnit      Specialized Sphere used as Default Eye
  T3dfxEyeViewUnit  Specialized T3dfxVertexUnit used for showing Eye Rays

  T3dfxExtentUnit

  //----------------------------------------------------------------------------
  // Object Lists

  T3dfxObjectListBaseUnit    Base List
  T3dfxObjectListUnit        Scene Objects List
  T3dfxObjectChildListUnit   Object Childrens
  T3dfxCompFactoryUnit       Component Factory

  TMyFactoryBaseUnit       Object Factory
  T3dfxBaseFactoryUnit       Object Factory

  //----------------------------------------------------------------------------
  // Basic Objects and their Vertex Lists & Buffers
  
  T3dfxContainerUnit      Basic Container without any primitives

  T3dfxPrimUnit,          Base Class with Material
  T3dfxVertexedUnit       Base Class with Vertex Buffers

  T3dfxVertexBufferUnit   Base for Vertex Buffers
  T3dfxVertexUnit         Base for Vertex List
  T3dfxVbUnit

  T3dfxConLineUnit        T3dfxVbConLineUnit Connection Line

  T3dfxShockWaveUnit      T3dfxVbShockWaveUnit (class Vb)

  // PointLists

  T3dfxPointListUnit      T3dfxVbPointListUnit
  T3dfxGalaxUnit          T3dfxVbGalaxUnit       (Class Vb)
  T3dfxPointFireUnit      T3dfxVbPointFireUnit   (Class Vb)
  T3dfxScrapsUnit         T3dfxVbScrapsUnit      (Class Vb)
  T3dfxGridUnit           T3dfxVbGridUnit        (Class Vb)
  T3dfxBeaconUnit         Beacon

  // LineList and Line Stripes

  T3dfxLineListUnit         T3dfxVbLineListUnit
  T3dfxLineUnit
  T3dfxExtentBoxSimpleUnit  T3dfxVbExtentBoxSimpleUnit (class Vb)
  T3dfxOcclusionBoxUnit     T3dfxVbExtentBoxSimpleUnit (class Vb)
  T3dfxConLineUnit          Connection Line between two Objects
  T3dfxLaserLineUnit        Laser Beam

  // Triangle Stripes Objects

  T3dfxTriStripeUnit      T3dfxVbTriStripeUnit
  T3dfxTextureUnit        T3dfxTextureD3DUnit
  T3dfxDynamicUnit
  T3dfxRectUnit           T3dfxVbRectNormalUnit   / T3dfxVbRectTextureUnit
  T3dfxCubeUnit           T3dfxVbCubeNormalUnit   / T3dfxVbCubeTextureUnit
  T3dfxTubeUnit           T3dfxVbTubeNormalUnit   / T3dfxVbTubeTextureUnit
  T3dfxGlobeUnit          T3dfxVbSphereNormalUnit / T3dfxVbSphereTextureUnit
  T3dfxBoardUnit          T3dfxVbBoardUnit        (class Vb)
  T3dfxArrowUnit          T3dfxVbArrowUnit        (class Vb)
  T3dfxBulletUnit         T3dfxVbBulletUnit       (class Vb)
  T3dfxRocketUnit         T3dfxVbRocketUnit       (class Vb)

  T3dfxTriCompUnit
  T3dfxTriEditUnit        T3dfxVbNormalsUnit / T3dfxVbPositionsUnit

  // Mesh Type Objects

  T3dfxMeshUnit           Base Mesh class
  T3dfxMeshFileUnit       Mesh from File
  T3dfxMeshTextUnit       Mesh from Text

  // Component Object

  T3dfxCompTypeUnit       Component Type Object
  T3dfxCompFactoryUnit    Component Type Factory
  T3dfxCompInstUnit       Component Instance Object
  T3dfxComponentUnit      Component Instance

  // Lights

  T3dfxLightUnit          Base Light
  T3dfxLightFlashUnit     Flash Light
  T3dfxLightSpotUnit      Spot Light
  T3dfxLightPointUnit     Point Light
  T3dfxLightListUnit      Light List
  T3dfxLightFactoryUnit   Light Factory

  // Special objects for User Interface only

  T3dfxWorldUnit              T3dfxVbWorldUnit
  T3dfxEyeViewUnit            T3dfxVbLookAtUnit
  T3dfxScreenLineUnit         T3dfxVbRayUnit

*)

//------------------------------------------------------------------------------
// Form Used
//------------------------------------------------------------------------------
type
  TGrapeMain = class(TForm)
    Frame11: TFrame1;
    InfoPanel: TPanel;
    MenuPort: TPopupMenu;
    TRackFrame1: TTRackFrame;
    Splitter1: TPanel;
    Splitter2: TPanel;
    Splitter3: TPanel;
    ObjectListFrame1: TObjectListFrame;
    LogFrame1: TLogFrame;
    MenuImages: TImageList;
    ObjectFrame1: TObjectFrame;
    SceenFrame1: TSceenFrame;
    TestLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuExitClick(Sender: TObject);
    procedure InfoPanelResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuPortPopup(Sender: TObject);
    procedure SetTrackingOnOff(Sender: TObject);
    procedure Splitter2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Splitter1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Splitter1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Splitter1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    //procedure FormDestroy(Sender: TObject);
  private
    //--------------------------------------------------------------------------
    // Forms attributes

    //--------------------------------------------------------------------------
    // Timer for Startup and Rendering

    objTimer  : TTimer;  // Frame Rate Timer
    objPinger : TTimer;  // Main Timer

    //--------------------------------------------------------------------------
    // Processes

    objProcesses    : T3dfxProcList;
    objProcInit     : T3dfxProcAppInit;
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

    objSplitter3Use  : boolean;
    objSplitter3Down : boolean;
    objSplitter3Last : integer;

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

    // Pinger Method

    procedure MyPingerEvent (Sender: TObject);

    // Initialize resizing of Form Controls

    procedure ResizeInit;   // Resize Init

    // Internal Methods

    procedure SetFontProp;      // Set Font Properties
    procedure LoadCursors;      // Load Predefined Cursors
    procedure SetWindowPos;     // Set Window position and Size

    // Property Methods

    function  GetViewPortFocus   : boolean;
    function  GetObjectListFocus : boolean;

    procedure SetText(const Value : string);

  public
    destructor Destroy; override;

    // Shutdown Application

    procedure StartUp;
    procedure ShutDown;

    //--------------------------------------------------------------------------
    // Panel Top

    procedure ResizeInt; // Resize all Controls

    //--------------------------------------------------------------------------
    // Tracking View

    procedure ShowTracking;

    //--------------------------------------------------------------------------
    // Log View

    procedure LogWin (const sLine : string);

    //--------------------------------------------------------------------------
    // Frame1 forwarding

    procedure CopyToClipBoard;
    procedure PopViewMenu(const Pos : TPoint);

    //--------------------------------------------------------------------------
    // Properties

    //property pViewFrame : TFrame1 read FRame11;

    property pViewPortFocus   : boolean read GetViewPortFocus;
    property pObjectListFocus : boolean read GetObjectListFocus;

    property pText : string write SetText;
  end;

var
  GrapeMain : TGrapeMain;

implementation
{$R *.dfm}

uses
  T3dfxGeometryUnit,     // Math Functions
  TResStringUnit,
  T3dfxStrUnit,          // String Class
  TGenTextFileUnit,
  TMySettingsUnit,       // Application Settings
  T3dfxGuiUnit,          // User Interface
  T3dfxSceenUnit,        // Cur Scene
  TMyMenuUnit,           // Menus
  TMyMessageFactoryUnit, // Message Qeue
  T3dfxScenePickUnit,    // Pick a Scene
  T3dfxSceneFactoryUnit, // Scene Factory

  TGenLogUnit,           // Log Object
  TGenClassesUnit;       // Class Definitions

const
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

    // Popup the Viewport Menu (called from ViewPort)

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
var
  tc : TIMECAPS;
begin
  Application.Title := Str(rsGrape);
  self.Caption      := Str(rsGrape);

  TheLog.pMemo := LogFRame1.Memo1;

  timeGetDevCaps(@tc, sizeof(tc));
  Log('Timer Min ' + IntToStr(tc.wPeriodMin) +
           ' Max ' + IntToStr(tc.wPeriodMax));
           
  //----------------------------------------------------------------------------
  // Create all Process Objects
  //----------------------------------------------------------------------------

  objProcesses := T3dfxProcList.Create;

  // Application Initiate Process

  objProcInit  := T3dfxProcAppInit.Create;
  objProcesses.AddProc(objProcInit);

  // Application ShutDown Process

  objProcShutDown := T3dfxProcMainShutDown.Create;
  objProcesses.AddProc(objProcShutDown);

  // Key and Wheel Process

  objProcKeys := T3dfxProcKeys.Create;
  objProcesses.AddProc(objProcKeys);

  // Start Initialize Process

{$IFDEF DEFDEBUG}
  LogMemToFile2('T3dfxProcAppInit.Create', AllocMemSize);
{$ENDIF}

  objProcInit.Perform;
end;
procedure TGrapeMain.SetText(const Value : string);
begin
  self.Caption := Value;
end;
//------------------------------------------------------------------------------
//  Startup Main Form
//------------------------------------------------------------------------------
procedure TGrapeMain.StartUp;
begin

  // Initiate all Local properties

  OnAppClosing          := false;       // Not Closing
  Application.OnMessage := MyOnMessage; // Key Manage
  objKeyDown            := false;       // Key is not down
  self.KeyPreview       := true;        // Preview all Keys

  // Set the Global Variables

  SetFontProp;  // Compute Font Properties
  LoadCursors;  // Load all Cursors

  // Create the Startup and Rendering Timer

  objTimer := TTimer.Create(Application);
  objTimer.Enabled  := true;
  objTimer.Interval := 10;
  objTimer.OnTimer  := MainLoop;

{$IFDEF DEFDEBUG}
  LogMemToFile2(self.ClassName + resLogStartUp, AllocMemSize);
{$ENDIF}

  // Startup Log Frame

  LogFrame1.Startup;

  // Set Frames On or Off

  SceenFrame1.pOn       := AppSettings.pSceneOn;
  SceenFrame1.pHgt      := AppSettings.pSceneHeigth;
  ObjectListFrame1.pOn  := AppSettings.pListOn;
  ObjectListFrame1.pHgt := AppSettings.pListHeigth;
  ObjectFrame1.pOn      := AppSettings.pPropOn;
  ObjectFrame1.pHgt     := AppSettings.pPropHeight;
  TrackFrame1.pOn       := AppSettings.pTrackingOn;
  LogFrame1.pOn         := AppSettings.pLogOn;

  // Initate some Frames

  Frame11.Startup;
  Frame11.pTextureWdt := AppSettings.pTextureWdt;

  TrackFrame1.StartUp;

  // Resize All Controls

  SetWindowPos; // Set Main Windows Position and Size
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
  Ind  : integer;
  sTmp : string;
begin

{$IFDEF DEFDEBUG}
  LogToFile('');
  LogToFile(self.ClassName + '.MainLoop' + CLN);
{$ENDIF}

  // Disable the Timer and reset OnTimer event call

  objTimer.Enabled  := false;
  objTimer.OnTimer  := RenderTimer;
  objTimer.Interval := 1;

{$IFDEF DEFDEBUG}
  LogMemToFile2('Run', AllocMemSize);
{$ENDIF}

  // Perform Initiation number 2

  objProcInit.Perform2;

  // Find out if DevBase was nitiated ok

  if not DevBase.pDeviceInit then
    begin
      objTimer.Enabled := false;
      OnAppClosing     := true;
      self.Close;
{$IFDEF DEFDEBUG}
      LogMemToFile;
{$ENDIF}
      EXIT;
    end;

  // Resolve File Name using the App Settings
  
  sTmp := ResolveFileName('', AppSettings.pSceneFile);
  if (not IsFile(sTmp)) then
    begin
      sTmp := T3dfxScenePick.PickScene(AppSettings.pComFolder);
    end;

  SceneFactory.SceneLoadFromFile(sTmp);

  // Set Scene dependent properties

  SceenFrame1.SceneFrameSetup;

  // StartUp needed Frames

  ObjectListFrame1.ObjectListStartUp;
  ObjectFrame1.ObjectFrameStartUp(ObjectListFrame1.ObjectImages);

  // Start the Pinger

  objPinger := TTimer.Create(self);
  objPinger.Interval := 100;
  objPinger.OnTimer := MyPingerEvent;
  objPinger.Enabled := true;


{$IFDEF DEFDEBUG}
  LogMemToFile2('Entering Loop', AllocMemSize);
  LogToFile('');
{$ENDIF}

  LogToFile('--------------------------- INITATED ----------------------------');

  // Perform main loop until closing Application

  Ind  := 0;
  while (not OnAppClosing) do
    begin
      DevBase.PerformRenderFrame;

      // Start the Render Timer to get rendering while Processing Messages

      objTimer.Enabled := true;

      // Get rid of old Mouse Key Events

      TakeMouseKey;

      // Get new Events. If Timer fires this will Render Viewports in
      // a slower Frame Rate while menues etc is showed

      Inc(Ind);
      if (Ind > 0) then
        begin
          Application.ProcessMessages;
          Ind := 0;
        end;

      // Disable the Render Timer

      objTimer.Enabled := false;
    end;

  LogToFile('');
  LogToFile('---------------------------- CLOSING ----------------------------');

  MsgQueue.StopQeue;

  objPinger.Enabled := false;
  objPinger.Free;
  
{$IFDEF DEFDEBUG}
  LogToFile('');
  LogToFile(self.ClassName + resLogShutDown + CLN);
  LogMemToFile;
  sTmp := objProcShutDown.ClassName;
  LogToFile('  ' + sTmp + '.Perform');
  LogMemToFile;
{$ENDIF}

  // Start Application ShutDown Process

  objProcShutDown.Perform;

  // Close My Processes

{$IFDEF DEFDEBUG}
  LogToFile('');
  LogToFile(self.ClassName + ':Processes' + resLogShutDown + CLN);
{$ENDIF}

  objProcesses.Free;

  LogToFile('');
{$IFDEF DEFDEBUG}
  LogToFile('  ' + sTmp + '.Performed');
  LogMemToFile;
{$ENDIF}
end;
//------------------------------------------------------------------------------
// Render Timer will trigger on long ProcessMessages
//------------------------------------------------------------------------------
procedure TGrapeMain.RenderTimer(Sender: TObject);
begin
  // Disable Render Timer

  objTimer.Enabled := false;

  // Run one Frame Loop

  DevBase.PerformRenderFrame;

  // Restart timer if not Application is closing

  if (not OnAppClosing) then objTimer.Enabled := true;
end;
//------------------------------------------------------------------------------
// Pinger
//------------------------------------------------------------------------------
procedure TGrapeMain.MyPingerEvent (Sender: TObject);
begin
  //LogFrame1.Ping;
  SceenFrame1.Ping;
  ObjectListFrame1.Ping;
  ObjectFrame1.Ping;
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

  TrackFrame1.ShutDown;           // Tracking Debug Frame
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  ObjectListFrame1.ObjectListShutDown;      // Object List Frame
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  SceenFrame1.SceneFrameShutdown; // Scene Frame
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  ObjectFrame1.ObjectFrameShutdown;          // Obejct Properties Frame
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  LogFrame1.ShutDown;             // Log Frame ShutDown
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  Frame11.ShutDown;               // Render Frame ShutDown
{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}
end;
//------------------------------------------------------------------------------
//  On Destroy
//------------------------------------------------------------------------------
destructor TGrapeMain.Destroy;
begin
  LogLastMemToFile(' Main Destroyed');
end;
//------------------------------------------------------------------------------
//
//                              USER INTERFACE
//
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
  if GrapeMain.pViewPortFocus and (DevBase <> nil) then
    begin
      DevBase.WheelInput((WheelDelta > 0), Shift);
      Handled := true;
    end;
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
//  Pop Main Window Menu
//------------------------------------------------------------------------------
procedure TGrapeMain.PopViewMenu(const Pos : TPoint);
begin
  // This will CAll MenuPortPopup

  self.MenuPort.Popup(Pos.x,Pos.y);
end;
//------------------------------------------------------------------------------
// ViewPort Menu Popup
//------------------------------------------------------------------------------
procedure TGrapeMain.MenuPortPopup(Sender: TObject);
var
  pScene : T3dfxSceen;
begin
  // Clear all Menu Items and reload them

  MenuPort.Items.Clear;
  pScene := DevBase.pCurScene;
  if (pScene <> nil) then
    begin
      MyMenus.LoadPopupMenu(pScene, TMyMenuObjInsert,MenuPort);
      MyMenus.LoadPopupMenu(pScene, TMyMenuView,MenuPort);
    end;
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
//
//                               OBJECT TRACE WINDOW
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
  // LogWinPos(GrapeMain,' (FormResize)');
end;
//------------------------------------------------------------------------------
// Set Font Data
//------------------------------------------------------------------------------
procedure TGrapeMain.SetFontProp;
begin
  TestLabel.Caption := 'Texture :';
  TextHgt  := TestLabel.Height + Brd*2;
  LabelWdt := TestLabel.Width + Brd * 2;
  TestLabel.Caption := 'X';
  CharWdt  := TestLabel.Width;
  TestLabel.Visible := false;
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
  //LogWinPos(InfoPanel,' (PanelResize)');
  ResizeInit;
  ResizeInt;
end;
//------------------------------------------------------------------------------
// Resize All Controls Initially (Not dynamically adjustable parts)
//------------------------------------------------------------------------------
procedure TGrapeMain.ResizeInit;
begin
  // Set Sizes of Main Windows Init

  SetControlSize(SceenFrame1, 0, InfoPanel.ClientWidth,
    Brd, SceenFrame1.Height);

  // Set Splitters Static geometry

  SetControlSize(Splitter1,0,InfoPanel.ClientWidth,Splitter1.Top,SplitterHgt);
  SetControlSize(Splitter2,0,InfoPanel.ClientWidth,Splitter2.Top,SplitterHgt);
  SetControlSize(Splitter3,0,InfoPanel.ClientWidth,Splitter3.Top,SplitterHgt);
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
  // 3) else if ObjectFrame is Open, we use that as slack
  // 4) else if Object List Frame is Open we use that as slack
  // 5) else if Scene FRame is Open, we use that as slack
  // 5) Else we just position them as is

  if LogFrame1.pOn then
    begin
      // Log Frame is Open, Use that as Slack
      // Calculate the Height to fill it up

      NewHgt := InfoPanel.ClientHeight  -
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

  // Use Object Frame if its Open

  if (not bDone) and ObjectFrame1.pOn then
    begin
      // Object Frame is Open, Use that as Slack
      // Calculate Height to fill it up

      NewHgt := InfoPanel.ClientHeight  -
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

  // Use Object List Frame if its open

  if (not bDone) and ObjectListFrame1.pOn then
    begin
      // Object Frame is Open, Use that as Slack
      // Calculate Height to fill it up

      NewHgt := InfoPanel.ClientHeight  -
                SceenFrame1.Height      - SplitterHgt -
                ObjectFrame1.Height     - SplitterHgt -
                TrackFrame1.Height      - SplitterHgt -
                LogFrame1.Height        - SplitterHgt;

      // If the height is not atleast two rows there is not enough place, so
      // we need to adjust one of the other Frames

      if (NewHgt < ObjectListFrame1.pMinHgt) then
        begin
          // Set Log Frame at a fixed min Height

          ObjectListFrame1.pHgt := ObjectListFrame1.pMinHgt;

          // We are not done yet
        end
      else
        begin
          // The Slack is taken fully, we are done

          ObjectListFrame1.pHgt := NewHgt;
          bDone := true;
        end;
    end;

  // If not all Slack is taken, try Scene Prop as last resort

  if (not bDone) and SceenFrame1.pOn then
    begin
      // Else if Object List Frame is Open, Use that as Slack
      // Calculate Height to Fill it up

      SceenFrame1.pHgt :=
                InfoPanel.ClientHeight  -
                ObjectListFrame1.Height - SplitterHgt -
                ObjectFrame1.Height     - SplitterHgt -
                TrackFrame1.Height      - SplitterHgt -
                LogFrame1.Height        - SplitterHgt;

      // If this is negative, we are basically fully fucked
    end
  else
    begin
      // No Frame that can take Slack was Open, we just position them
      // From To Bottom. They should fit into and leav empty space below
    end;

  // Do the adjustment on each Frames and Splitter

  Splitter1.Top    := SceenFrame1.Top + SceenFrame1.Height;

  ObjectListFrame1.Top := SceenFrame1.Top + SceenFrame1.Height + SplitterHgt;

  Splitter2.Top    := ObjectListFrame1.Top + ObjectListFrame1.Height;
  ObjectFrame1.Top := Splitter2.Top + Splitter2.Height;

  Splitter3.Top    := ObjectFrame1.Top + ObjectFrame1.Height;
  TrackFrame1.Top  := Splitter3.Top + Splitter3.Height;
  LogFrame1.Top    := TrackFrame1.Top + TrackFrame1.Height + SplitterHgt;

  //----------------------------------------------------------------------------
  // Set Splitters On/Off and their Cursors

  objSplitter1Use := SceenFrame1.pOn;
  objSplitter2Use := ObjectListFrame1.pOn;
  objSplitter3Use := ObjectFrame1.pOn;

  if objSplitter1Use then
    Splitter1.Cursor := crVSplit
  else
    Splitter1.Cursor := crDefault;

  if objSplitter2Use then
    Splitter2.Cursor := crVSplit
  else
    Splitter2.Cursor := crDefault;

  if objSplitter3Use then
    Splitter3.Cursor := crVSplit
  else
    Splitter3.Cursor := crDefault;

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
//  Splitter 1 Mouse Move
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  dy : integer;
begin
  if (objSplitter1Down) and (ssLeft	in Shift) then
    begin
      dy := (Y - objSplitter2Last);
      objSplitter1Last := Y;

      // 1) User can move up until Scene Prop Frame is an Min Height

      if (SceenFrame1.Height <= SceenFrame1.pMinHgt) and
         (dy < 0) then
        dy := 0;

      // 2) User can Move Down All Things until Log Frame, Object Frame,
      //    Object List Frame all are at their Min Heights

      if (LogFrame1.Height <= LogFrame1.pMinHgt) and
         (ObjectListFrame1.Height <= ObjectListFrame1.pMinHgt) and
         (ObjectFrame1.Height <= ObjectFrame1.pMinHgt) and
         (dy > 0) then
         dy := 0;

      if (dy <> 0) then
        begin
          SceenFrame1.pHgt := SceenFrame1.pHgt + dy;
          objSplitter1Last := Y;

          ResizeInt;
        end;
    end;end;
//------------------------------------------------------------------------------
//  Splitter 1 Mouse Up
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  objSplitter1Down := false;
end;
//------------------------------------------------------------------------------
//  Splitter 2 Mouse Down
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
//  Splitter 2 Mouse Move
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  dy : integer;
begin
  if (objSplitter2Down) and (ssLeft	in Shift) then
    begin
      dy := (Y-objSplitter3Last);
      objSplitter2Last := Y;

      // 1) User can move up until Object List is an Min Height

      // 2) User can Move Down All Things until Log Frame and ObjectFrame
      //    both are at their Min Heights

      if (ObjectListFrame1.Height <= ObjectListFrame1.pMinHgt) and (dy < 0) then dy := 0;


      if (LogFrame1.Height <= LogFrame1.pMinHgt) and
         (ObjectFrame1.Height <= ObjectFrame1.pMinHgt) and (dy > 0) then dy := 0;

      if (dy <> 0) then
        begin
          ObjectListFrame1.pHgt := ObjectListFrame1.pHgt + dy;
          objSplitter2Last := Y;

          ResizeInt;
        end;
    end;
end;
//------------------------------------------------------------------------------
//  Splitter 2 Mouse Up
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  objSplitter2Down := false;
end;
//------------------------------------------------------------------------------
// Splitter 2 Mouse Down
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and objSplitter3Use then
    begin
      objSplitter3Down := true;
      objSplitter3Last := Y;
    end;
end;
//------------------------------------------------------------------------------
// Splitter 2 Mouse Move
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  dy : integer;
begin
  if (objSplitter3Down) and (ssLeft	in Shift) then
    begin
      dy := (Y-objSplitter3Last);
      objSplitter2Last := Y;

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
// Splitter 2 Mouse Up
//------------------------------------------------------------------------------
procedure TGrapeMain.Splitter3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  objSplitter3Down := false;
end;

initialization

  RegClass(TGrapeMain, 'DirectX7Unit');

end.
