unit TResStringUnit;

interface

uses
  Windows;
  
//------------------------------------------------------------------------------
//  Resource Strings
//  1) String resources begin with //begin on a sinle line
//  2) Each String has a Uid from the order in the file begining with 0
//  3) Each string is defined from // to end of line
//  4) If leading and/or trailing blanks is needed, string must be quoted (")
//  5) The order of definitions in this file is not important at all
//  6) In Code use Str(id : TResStringUid): string in T3dfxStrObjUnit
//  7) This file must be a part of the Application distribution
//------------------------------------------------------------------------------
type TResStringUid = (

//begin

  // Basic Strings

  rsGrape,                // Grape
  rsUnknown,              // Unknown
  rsNotExist,             // Dont exist
  rsNotValid,             // Not Valid
  rsDestroy,              // Destroy
  rsOverwrite,            // already exist! Do you want to overwrite it?
  rsObjects,              // Objects

  rsNoHit,                // No Hit
  rsPoint,                // Point
  rsLine,                 // Line
  rsTriangle,             // Triangle
  
  // Application Strings

  rsAppComFolder,         // Application Common Folder

  // Scene strings

  rsScene,                // Scene
  rsSceneProp,            // Scene Properties
  rsSceneNewName,         // New Sccene
  rsSceneComFolder,       // Scene Common Folder
  rsSceneInfo,            // Scene Information
  rsSceneName,            // Scene Name
  rsSceneFileName,        // Scene File Name (absolute path)
  rsSceneHint,            // Hint On/Off
  rsSceneSaveAs,          // Save Scene As

  rsSceneBkg,             // Background';
  rsSceneBkgProp,         // Background Properties
  rsSceneBkgColor,        // Background Color
  rsSceneBkgColorR,       // Background Color (red)
  rsSceneBkgColorG,       // Background Color (green)
  rsSceneBkgColorB,       // Background Color (blue)
  rsSceneAmbient,         // Ambient Light

  rsSceneFog,             // Fog Settings
  rsSceneFogOn,           // Fog On/Off (F6)
  rsSceneFogMin,          // Fog Start Distance from Eye
  rsSceneFogMax,          // Fog Depth

  rsSceneGrid,            // Grid
  rsSceneGridHint,        // Grid & Snap To (Position, Rotation, Scale etc.)
  rsSceneGridOn,          // Show Grid On/Off
  rsSceneGridX,           // Grid (x)
  rsSceneGridY,           // Grid (y)
  rsSceneGridZ,           // Grid (z)
  rsSceneGridAng,         // Snap to Angle (degree)
  rsSceneGridScl,         // Snap to Scale
  rsSceneSnapTo,          // Snap to other Objects (On/Off)

  rsSceneView,            // View
  rsSceneViewProp,        // Viewing Properties
  rsScenePersp,           // Perspecitve on/off (F1)
  rsSceneWorld,           // World Coordinates On/Off
  rsSceneLookAt,          // Look At Vector On/Off
  rsSceneSpeed,           // Speed factor (F8 = Slow, F7 = Stop)
  rsSceneResolution,      // Screen Resolution
  rsSceneSolid,           // Solid/Wire Frame On/Off (F5)

  rsSceneOptimizeTitle,   // Optimization
  rsSceneOptimize,        // Optimization Settings
  rsSceneFrustum,         // Frustum Culling On/Off
  rsSceneOcclusion,       // Occlusion Culling On/Off
  rsSceneOcclusionArea,   // Occlusion Area (default 0.1)
  rsScenePrecision,       // Object Precision adjust On/Off
  rsSceneWaitState,       // Set Average FPS to 120 On/Off

  // Object Names

  rsObject,               // Object
  rsObjContainer,         // Container
  rsObjComponent,         // NewComp
  rsObjCube,              // Cube
  rsObjSphere,            // Sphere
  rsObjTube,              // Tube
  rsObjPointList,         // Points
  rsObjLineList,          // Line
  rsObjRect,              // Rectangle
  rsObjMesh,              // Mesh
  rsObjCompInst,          // Component
  rsObjTriComp,           // Tricomp
  rsObjEye,               // Eye
  rsObjEyeExtra,          // Extra Eye
  rsObjArrow,             // Arrow
  rsObjBoard,             // Board
  rsObjText,              // Text
  rsObjLight,             // Light
  rsObjLightBulb,         // Light Bulb
  rsObjLightSpot,         // Spot Light
  rsObjGalaxy,            // Galaxy
  rsObjRocket,            // Rocket
  rsObjShockWave,         // ShockWave
  rsObjScraps,            // Scraps
  rsObjBullet,            // Bullet
  rsObjConLine,           // Connection
  rsObjLaser,             // Laser
  rsObjPointFire,         // Fire
  rsObjScent,             // Beacon

  //----------------------------------------------------------------------------
  // Property Strings

  rsProp,                 // Property

  // Generic Information

  rsPropInfo,             // Information
  rsPropInfoHint,         // Generic properties of Object
  rsPropNameHint,         // Objects Name (default object type)
  rsPropTypeHint,         // Objects Type (read only)
  rsPropTagHint,          // Objects Tag (number)
  rsPropPrecMaxHint,      // Objects Precision (number of vertices)
  rsPropPrecAdjHint,      // Auto Precision Adjustment (On/Off)
  rsPropPickableHint,     // Object can be picked (On/Off)
  rsPropFleetHint,        // Fleet Designation
  rsPropEnergyHint,       // Energy Load

  // Action Properties

  rsPropAction,             // Actions
  rsPropActionFire,         // Fire Object
  rsPropActionFlash,        // Flash Action
  rsPropActionMove,         // Move Object
  rsPropActionRotate,       // Rotate Object
  rsPropActionScale,        // Scale Object
  rsPropActionTrackRandom,  // Track Random
  rsPropActionTrackObject,  // Track Object
  rsPropActionSearchEnemy,  // Search Enemy
  rsPropActionGoHome,       // Go To Mother
  rsPropActionHint,         // Objects Action and Tracking Properties
  rsPropTrackOnHint,        // Allow Tracking on this Object
  rsPropTrackIdHint,        // Uid of Tracked Object
  rsPropTrackNone,          // No Target
  rsPropTrackAhead,         // Track ahead of Objects movement
  rsPropTrackRandHint,      // Track other Objects Randomly (On/Off)
  rsPropFireBulletHint,     // Able to Fire Bullets (On/Off) (Key F & G)
  rsPropFireRocketHint,     // Able to Fire Rockets (On/Off) (Key K)
  rsPropAngVel,             // Angle Velocity
  rsPropAngVelHint,         // Rotation Angle Velocity (degree)
  rsPropAngVelXHint,        // Rotation Velocity around X-axis (degree)
  rsPropAngVelYHint,        // Rotation Velocity around Y-axis (degree)
  rsPropAngVelZHint,        // Rotation Velocity around Z-axis (degree)
  rsPropAngVelMaxXHint,     // Max Rotation Velocity around X-axis (degree)
  rsPropAngVelMaxYHint,     // Max Rotation Velocity around Y-axis (degree)
  rsPropAngVelMaxZHint,     // Max Rotation Velocity around Z-axis (degree)
  rsPropVel,                // Velocity
  rsPropVelHint,            // Velocity in Look At direction
  rsPropVelMaxHint,         // Max Velocity in Look At direction
  rsPropActionTime,         // Time Action
  rsPropActionMotherShip,   // Mother Ship

  // Geometry Properties

  rsPropOrigin,           // Position
  rsPropOriginHint,       // Position in World Space
  rsPropOriginXHint,      // Position (x)
  rsPropOriginYHint,      // Position (y)
  rsPropOriginZHint,      // Position (z)

  rsPropCenter,           // Centering
  rsPropCenterHint,       // Centering of object in all directions (x,y,z)
  rsPropCenterXHint,      // Centering of object in X direction
  rsPropCenterYHint,      // Centering of object in Y direction
  rsPropCenterZHint,      // Centering of object in Z direction
  rsPropCenterLeft,       // Left
  rsPropCenterMiddle,     // Middle
  rsPropCenterRight,      // Right
  rsPropCenterUp,         // Up
  rsPropCenterDown,       // Down
  rsPropCenterBack,       // Back
  rsPropCenterFront,      // Front

  rsPropSize,               // Size
  rsPropSizeHint,           // Size of object (Width, Height and Depth)
  rsPropSizeXHint,          // Width (x)
  rsPropSizeYHint,          // Height (y)
  rsPropSizeZHint,          // Depth (z)
  rsPropSizeRectHint,       // Size of object (Width and Height)
  rsPropSizeTubeTopHint,    // Top Width (x & z)
  rsPropSizeTubeBottomHint, // Bottom Width (x & z)

  rsPropScl,              // Scale
  rsPropSclHint,          // Object Scale in all directions
  rsPropSclXHint,         // Object Scale / Width (x)
  rsPropSclYHint,         // Object Scale / Height (y)
  rsPropSclZHint,         // Object Scale / Depth (z)
  rsPropSclAllHint,       // Scale Object in all directions at the same time

  rsPropRot,              // Rotation
  rsPropRotHint,          // Objects Rotation around x,y and z axis (degree)
  rsPropRotXHint,         // Objects Rotation around x-axis
  rsPropRotYHint,         // Objects Rotation around y-axis
  rsPropRotZHint,         // Objects Rotation around z-axis

  // View Properties

  rsPropView,             // View
  rsPropViewHint,         // Eye position, Look At, and Up Vector
  rsPropViewEyePos,       // Eye Poistion
  rsPropViewEyePosHint,   // Eye Position in Object Space
  rsPropViewEyePosXHint,  // Eye Position (x)
  rsPropViewEyePosYHint,  // Eye Position (y)
  rsPropViewEyePosZHint,  // Eye Position (z)
  rsPropViewLookAtHint,   // Forward Look At direction
  rsPropViewUpVectorHint, // Up vector direction

  rsPropDirectionPX, // X+
  rsPropDirectionNX, // X-
  rsPropDirectionPY, // Y+
  rsPropDirectionNY, // Y-
  rsPropDirectionPZ, // Z+
  rsPropDirectionNZ, // Z-  

  // Material & Color

  rsPropColor,            // Color
  rsPropColorR,           // Color (red)
  rsPropColorG,           // Color (green)
  rsPropColorB,           // Color (blue)
  rsPropColorA,           // Color (alpha)
  rsPropAmbient,          // Ambient
  rsPropDiffuse,          // Diffuse
  rsPropSpecular,         // Specular
  rsPropEmissive,         // Emissive

  rsMtrlName,             // Material
  rsMtrlHint,             // Objects material, color etc.
  rsMtrlColorHint,        // Objects Material Color
  rsMtrlPowerHint,        // Object Specular Power (0=Matte)
  rsMtrlTranspHint,       // Transparency On/Off
  rsMtrlTranspFactorHint, // Transparency Blend Factor
  rsMtrlOutsideHint,      // Show Outside Faces

  // Texture Properties

  rsObjTxt,               // Texture
  rsObjTxtHint,           // Texture Properties
  rsObjTxtOnHint,         // Texture (On/Off)
  rsObjTxtWrapHint,       // Texture Wrapping (On/Off)
  rsObjTxtWrapMultXHint,  // Texture Wrapping Multipier X
  rsObjTxtWrapMultYHint,  // Texture Wrapping Multipier Y
  rsObjTxtWrapOffsXHint,  // Texture Wrapping Offset X
  rsObjTxtWrapOffsYHint,  // Texture Wrapping Offset Y
  rsObjTxtLeftHint,       // Texture Start X
  rsObjTxtRightHint,      // Texture End X
  rsObjTxtTopHint,        // Texture Start Y
  rsObjTxtBottomHint,     // Texture End Y
  rsObjTxtFrontHint,      // Front Texture Filename

  rsObjTxtStyleHint,      // Texture Style (Front, Front & Back, All Sides)
  rsObjTxtStyleFront,     // Front
  rsObjTxtStyleFrontBack, // Front & Back
  rsObjTxtStyleAll,       // All Sides
  rsObjTxtBackHint,       // Back Texture Filename
  rsObjTxtPickTitle,      // Pick New Texture

  // Mesh Properties

  rsObjMeshFile,          // Mesh File
  rsObjMeshFileHint,      // Mesh File Properties
  rsObjMeshFileNameHint,  // Mesh FileName (DblClick to Pick)
  rsObjMeshPickTitle,     // Pick New Mesh

  // Text Properties

  rsObjTextHint,          // Text Properties
  rsObjTextDefault,       // Ariel
  rsObjTextStringHint,    // Text string
  rsObjTextFontHint,      // Text Font Name
  rsObjTextBoldHint,      // Text Font Bold (On/Off)
  rsObjTextItalicHint,    // Text Font Italic (On/Off)

  // Component Instance Properties

  rsObjCompHint,          // Component Properties
  rsObjCompFileHint,      // Component FileName (DblClick to Pick new)
  rsObjCompPickTitle,     // Pick a new Component

  // Connection Line Properties

  rsObjConLineAHint,      // Connection Start
  rsObjConLineBHint,      // Connection End
  rsObjConLineNot,        // Not Connected

  //----------------------------------------------------------------------------
  // Menus

  rsMenuUndefined,        // Menu Command is undefined

  // Scene Menu

  rsSceneNew,             // New (empty)
  rsSceneOpenPick,        // Open...
  rsSceneOpenMain,        // Open
  rsSceneOpenRecent,      // Open Recent
  rsSceneSave,            // Save
  rsSceneCopyToClipboard, // Copy to Clipboard
  rsSceneExit,            // Exit

  // Object Menu

  rsObjInsert,            // Insert
  rsObjNewText,           // New Text
  rsObjMeshPick,          // Pick a Mesh
  rsObjCnvMain,           // Convert
  rsObjLoadMain,          // Load
  rsObjLoadAsObjectMain,  // As Object
  rsObjLoadAsObjectBrws,  // As Object...
  rsObjLoadAsCompMain,    // As Component
  rsObjLoadAsCompBrws,    // As Component...
  rsObjLoadPickComp,      // Pick a Component

  rsObjSave,              // Save
  rsObjSaveAs,            // Save As...
  rsObjSaveAsTitle,       // Save Object


  rsObjCut,               // Cut           (Ctrl-X)
  rsObjCopy,              // Copy        (Ctrl-C)
  rsObjPaste,             // Paste       (Ctrl-V)
  rsObjDelete,            // Delete      (Del)
  rsObjEditPlane,         // Set Edit Plane

  rsObjViewMain,          // View
  rsObjViewUseEye,        // Use Scene Eye   (V)
  rsObjViewUseObj,        // Use Selected      (V)

  // Tracking Window

  rsTrfMsg,               // Msg
  rsTrfPrf,               // Performance
  rsTrfTrackOn,           // Tracking Frame
  rsTrfTrackType,         // Tracking Type
  rsTrfTracking,          // Show Object Tracking
  rsTrfOcclusion,         // Show Occlusion Areas
  rsTrfOptimization,      // Show Optimization

  rsTrfFrustCull,         // Frustum   Culled  :
  rsTrfOcclCull,          // Occlusion Culled  :
  rsTrfObjDrawn,          // Objects    Drawn :
  rsTrfObjTot,            // Objects    Total   :
  rsTrfMoving,            // Moving :
  rsTrfRender,            // Render :
  rsTrfWait,              // Wait     :
  rsTrfFRame,             // Frame  :
  rsTrfFrustTime,         // Frustum  Timing :
  rsTrfOcclArea,          // OcclArea Timing :
  rsTrfOcclHide,          // OcclHide Timing :
  rsTrfRenderTime,        // Render   Timing :
  rsTrfPresTime,          // Present  Timing :
  rsTrfFps,               // Fps : 

  // Error Strings

  rsErrCountNotZero,      // Count is not Zero
  rsErrPropUndefined      // Property is undefined

//end

  );

implementation

uses
  TGenClassesUnit;

//------------------------------------------------------------------------------
//                                     INIT
//------------------------------------------------------------------------------
initialization

  RegSymbol ('ResourceStrings', 'TResStringUnit');

end.
 