object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 320
  Height = 240
  Color = clSilver
  ParentColor = False
  TabOrder = 0
  OnDblClick = FrameDblClick
  OnMouseDown = FrameMouseDown
  OnMouseMove = FrameMouseMove
  OnMouseUp = FrameMouseUp
  OnResize = FrameResize
  object KeyGrabber: TEdit
    Left = 8
    Top = 8
    Width = 57
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clNone
    TabOrder = 0
    Text = 'KeyGrabber'
  end
  inline TextureFrame1: TTextureFrame
    Left = 8
    Top = 48
    Width = 220
    Height = 88
    TabOrder = 1
    inherited TexturePanel: TPanel
      Left = 8
    end
  end
end
