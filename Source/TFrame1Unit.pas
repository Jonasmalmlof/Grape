unit TFrame1Unit;

interface

uses
  Windows,  Classes,  Controls,  Forms, StdCtrls, ExtCtrls, JPEG, SysUtils,
  Graphics, Clipbrd,

  T3dfxTypesUnit,     // Generic Types
  T3dfxBaseUnit,      // Sub Base Class
  T3dfxTriEditUnit,   // Triangle Strip Edit
  TTextureFrameUnit;  // Texture Frame Window
  
type
  TFrame1 = class(TFrame)
    KeyGrabber: TEdit;
    TextureFrame1: TTextureFrame;
    procedure FrameMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FrameResize(Sender: TObject);
    procedure FrameMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FrameMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FrameDblClick(Sender: TObject);
  private

    //--------------------------------------------------------------------------
    // Texture Frame Methods

    // Set/Get Texture Frame Visability

    function  GetTextureOn: boolean;
    procedure SetTextureOn(const b : boolean);

    // Set Texture Frame Width. (Height is self adjusting on Bitmap size)

    function  GetTextureWdt: integer;
    procedure SetTextureWdt(const wdt : integer);

    // Set/Get Texture Bitmap

    procedure SetTextureFile(const Name : string);

    // Set Current Object

    procedure SetObject(const pObj : T3dfxTriEdit);

    procedure HighLightNode(const Ind : integer);

    procedure GrabKeys;
    function  GetHasFocus : boolean;
  public
    constructor Create (AOwner : TComponent); override;
    destructor  Destroy; override;

    // Startup / ShutDown Frame

    procedure Startup;
    procedure ShutDown;

    function  GetDc : HDC;

    procedure CopyToClipBoard;

    //--------------------------------------------------------------------------
    // Properties

    property pTextureFile : string                       write SetTextureFile;
    property pObject      : T3dfxTriEdit                 write SetObject;

    property pTextureOn   : boolean read GetTextureOn    write SetTextureOn;
    property pTextureWdt  : integer read GetTextureWdt   write SetTextureWdt;

    property pHighLightNode : integer                    write HighLightNode;
    property pHasFocus      : boolean read GetHasFocus;
  end;

implementation

{$R *.dfm}

uses
  T3dfxUnit,        // Forward Mouse Input
  T3dfxGuiUnit,     // User Interface
  T3dfxHitUnit,     // Hit Detection
  TMySettingsUnit,  // Texture Window Size
  TGenClassesUnit;  // Class Definitions

const
  ImageBrd = 5;
  PanelBrd = 10;

  ResizeNo     = 0;
  ResizeWdt    = 1;
  ResizeHgt    = 2;
  ResizeWdtHgt = 3;

//------------------------------------------------------------------------------
// Create
//------------------------------------------------------------------------------
constructor TFrame1.Create (AOwner : TComponent);
begin
  inherited Create(AOwner);

{$IFDEF DEFDEBUG}
  LogMemToFile2(self.ClassName + resLogCreate, AllocMemSize);
{$ENDIF}
end;
//------------------------------------------------------------------------------
// Destroy
//------------------------------------------------------------------------------
destructor TFrame1.Destroy;
begin
{$IFDEF DEFDEBUG}
  LogMemToFile2(self.ClassName + resLogDestroy, AllocMemSize);
{$ENDIF}

  inherited Destroy;
end;
//------------------------------------------------------------------------------
// Startup
//------------------------------------------------------------------------------
procedure TFrame1.Startup;
begin
  TextureFrame1.Visible := false;

  // Place KeyGrabber Control out of visible space

  KeyGrabber.Left  := -10;
  KeyGrabber.Width := 5;

  TextureFRame1.DoubleBuffered := true;
  TextureFRame1.Width := 100;
  TextureFRame1.Height := 66;

  TextureFrame1.Startup;
  
{$IFDEF DEFDEBUG}
  LogMemToFile2(self.ClassName + resLogStartUp, AllocMemSize);
{$ENDIF}

end;
//------------------------------------------------------------------------------
// ShutDown FRame
//------------------------------------------------------------------------------
procedure TFrame1.ShutDown;
begin
{$IFDEF DEFDEBUG}
  LogToFile('');
  LogToFile(self.ClassName + resLogShutDown + ':');
{$ENDIF}

  AppSettings.pTextureWdt := self.pTextureWdt;
  TextureFrame1.ShutDown;
  KeyGrabber.Text := '';
end;
//------------------------------------------------------------------------------
// Get Device Context of this Frame
//------------------------------------------------------------------------------
function TFrame1.GetDc : HDC;
var
  notUsed : HWND;
begin
  result := GetDeviceContext(notUsed);
end;
//------------------------------------------------------------------------------
// Get Height of Texture Window
//------------------------------------------------------------------------------
function  TFrame1.GetTextureWdt: integer;
begin
  result := TextureFrame1.Width;
end;
//------------------------------------------------------------------------------
// Set Height of Texture Window
//------------------------------------------------------------------------------
procedure TFrame1.SetTextureWdt(const wdt : integer);
begin
  TextureFrame1.Width := wdt;
end;
//------------------------------------------------------------------------------
// Return if Texture is on or Off
//------------------------------------------------------------------------------
function TFrame1.GetTextureOn: boolean;
begin
  result := TextureFrame1.Visible;
end;
//------------------------------------------------------------------------------
// Show Texture Panel
//------------------------------------------------------------------------------
procedure TFrame1.SetTextureOn(const b : boolean);
begin
  TextureFrame1.Visible := b;
end;
//------------------------------------------------------------------------------
// Load Texture
//------------------------------------------------------------------------------
procedure TFrame1.SetTextureFile(const Name : string);
begin
  TextureFrame1.pTextureFile := Name;
  SetTextureOn(true);
end;
//------------------------------------------------------------------------------
// Add Texture Points
//------------------------------------------------------------------------------
procedure TFrame1.SetObject(const pObj : T3dfxTriEdit);
begin
  TextureFrame1.pObject := pObj;
end;
//------------------------------------------------------------------------------
// High light a Texture Node
//------------------------------------------------------------------------------
procedure TFrame1.HighLightNode(const Ind : integer);
begin
  if TextureFrame1.Visible then
    TextureFrame1.pHighLight := Ind;
end;
//------------------------------------------------------------------------------
// Return if Main Window has Focus or not
//------------------------------------------------------------------------------
function TFrame1.GetHasFocus : boolean;
begin
  result := KeyGrabber.Focused;
end;
//------------------------------------------------------------------------------
// Grab Key if not focused already
//------------------------------------------------------------------------------
procedure TFrame1.GrabKeys;
begin

  // Set Active Control to KeyGrabber if not already focused

  if (not KeyGrabber.Focused) then
    begin
      // Set KeyGrabber Edit Control as focused

      KeyGrabber.SetFocus;
    end;
end;
//------------------------------------------------------------------------------
// Mouse was pressed down
//------------------------------------------------------------------------------
procedure TFrame1.FrameMouseDown(Sender: TObject; Button: TMouseButton;
                                 Shift: TShiftState; X, Y: Integer);
begin
  GrabKeys;
  if (DevBase <> nil) then DevBase.MouseDownInput(x, y, Shift);
end;
//------------------------------------------------------------------------------
//  Adjust Object of Vuew on Mouse Movement
//------------------------------------------------------------------------------
procedure TFrame1.FrameMouseMove(Sender: TObject; Shift: TShiftState;
                                 X, Y: Integer);
begin
  GrabKeys;
  if (DevBase <> nil) then DevBase.MouseMoveInput(x, y, Shift);
end;
//------------------------------------------------------------------------------
// Mouse was released up
//------------------------------------------------------------------------------
procedure TFrame1.FrameMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  GrabKeys;
  if (DevBase <> nil) then DevBase.MouseUpInput(x, y, Shift);
end;
//------------------------------------------------------------------------------
// Enter/Leave Edit Mode
//------------------------------------------------------------------------------
procedure TFrame1.FrameDblClick(Sender: TObject);
begin
  if (DevBase <> nil) then DevBase.MouseDblClick;
end;
//------------------------------------------------------------------------------
// The Frame Size has Changed
//------------------------------------------------------------------------------
procedure TFrame1.FrameResize(Sender: TObject);
begin
  //LogWinPos(Self,' (FrameResize)');

  TextureFrame1.Left := PanelBrd;
  TextureFrame1.Top  := PanelBrd;

  Log('Frame W ' + IntToStr(self.Width) + ' H ' + IntToStr(self.Height));
end;
//-----------------------------------------------------------------------------
// Copy Scene to Clipboard
//-----------------------------------------------------------------------------
procedure TFrame1.CopyToClipBoard;
var
  tmpCanvas : TCanvas;
  tmpRect   : TRect;
  tmpBitMap : TBitmap;
  notUsed   : HWND;
begin
  // Create a temporary Canvas

  tmpCanvas := TCanvas.Create;

  // Get the Device Context from Rendering Window and set it to Canvas

  tmpCanvas.Handle := GetDeviceContext(notUsed);

  // Create a temporary Bitmap and copy canvas to it

  tmpBitMap        := TBitmap.Create;
  tmpBitMap.Height := self.Height;
  tmpBitMap.Width  := self.Width;

  tmpRect := Rect(0,0,self.Width,self.Height);

  tmpBitMap.Canvas.CopyRect(tmpRect, tmpCanvas, tmpRect);

  Clipboard.Assign(tmpBitMap);

  // Free all things

  tmpBitMap.Free;
  tmpCanvas.Free;
end;
//------------------------------------------------------------------------------
//                                    INITIALIZE
//------------------------------------------------------------------------------
initialization

  FindClass(TFrame1);

end.
