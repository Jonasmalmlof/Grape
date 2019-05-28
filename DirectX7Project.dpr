program DirectX7Project;



{%File 'Develop\Classes.txt'}
{%File 'Develop\ClassHier.txt'}
{%File 'Develop\Ducument.txt'}
{%File 'Develop\Modules.txt'}
{%File 'Develop\Symbols.txt'}

uses
  SysUtils,
  Forms,
  DirectX7Unit in 'DirectX7Unit.pas' {GrapeMain},
  TGenClassesUnit in '..\TGenUnits\TGenClassesUnit.pas',
  TFrame1Unit in 'TFrame1Unit.pas' {Frame1: TFrame},
  T3dfxUnit in 'T3dfxUnit.pas',
  T3dfxGalaxUnit in '..\MyDirectx\T3dfxGalaxUnit.pas',
  T3dfxRectUnit in '..\MyDirectx\T3dfxRectUnit.pas',
  T3dfxMeshUnit in '..\MyDirectx\T3dfxMeshUnit.pas',
  T3dfxEyeViewUnit in '..\MyDirectx\T3dfxEyeViewUnit.pas',
  TGenAverageUnit in '..\TGenUnits\TGenAverageUnit.pas',
  T3dfxRocketUnit in '..\MyDirectx\T3dfxRocketUnit.pas',
  T3dfxShockWaveUnit in '..\MyDirectx\T3dfxShockWaveUnit.pas',
  T3dfxScrapsUnit in '..\MyDirectx\T3dfxScrapsUnit.pas',
  T3dfxSceenUnit in '..\MyDirectx\T3dfxSceenUnit.pas',
  T3dfxBoardUnit in '..\MyDirectx\T3dfxBoardUnit.pas',
  T3dfxContainerUnit in '..\MyDirectx\T3dfxContainerUnit.pas',
  T3dfxTextureD3DUnit in '..\MyDirectx\T3dfxTextureD3DUnit.pas',
  T3dfxCubeUnit in '..\MyDirectx\T3dfxCubeUnit.pas',
  T3dfxScreenLineUnit in '..\MyDirectx\T3dfxScreenLineUnit.pas',
  T3dfxGeometryUnit in '..\MyDirectx\T3dfxGeometryUnit.pas',
  T3dfxPointListUnit in '..\MyDirectx\T3dfxPointListUnit.pas',
  T3dfxLineListUnit in '..\MyDirectx\T3dfxLineListUnit.pas',
  T3dfxTriStripeUnit in '..\MyDirectx\T3dfxTriStripeUnit.pas',
  T3dfxHitUnit in '..\MyDirectx\T3dfxHitUnit.pas',
  T3dfxLineUnit in '..\MyDirectx\T3dfxLineUnit.pas',
  TFpsTimerUnit in '..\MyDirectx\TFpsTimerUnit.pas',
  T3dfxBulletUnit in '..\MyDirectx\T3dfxBulletUnit.pas',
  T3dfxEyeUnit in '..\MyDirectx\T3dfxEyeUnit.pas',
  ObjectFrameUnit in '..\MyDirectx\ObjectFrameUnit.pas' {ObjectFrame: TFrame},
  T3dfxGuiUnit in '..\MyDirectx\T3dfxGuiUnit.pas',
  SubFrameBaseUnit in '..\MyDirectx\SubFrameBaseUnit.pas' {SubFrameBase: TFrame},
  TTRackFrameUnit in '..\MyDirectx\TTRackFrameUnit.pas' {TRackFrame: TFrame},
  TObjectListFrameUnit in '..\MyDirectx\TObjectListFrameUnit.pas' {ObjectListFrame: TFrame},
  TLogFrameUnit in '..\MyDirectx\TLogFrameUnit.pas' {LogFrame: TFrame},
  T3dfxWorldUnit in '..\MyDirectx\T3dfxWorldUnit.pas',
  T3dfxArrowUnit in '..\MyDirectx\T3dfxArrowUnit.pas',
  T3dfxLightUnit in '..\MyDirectx\T3dfxLightUnit.pas',
  T3dfxTubeUnit in '..\MyDirectx\T3dfxTubeUnit.pas',
  T3dfxLightListUnit in '..\MyDirectx\T3dfxLightListUnit.pas',
  T3dfxObjectListUnit in '..\MyDirectx\T3dfxObjectListUnit.pas',
  TSubPropFrameUnit in '..\MyDirectx\TSubPropFrameUnit.pas' {SubPropFrame: TFrame},
  TSceenFrameUnit in '..\MyDirectx\TSceenFrameUnit.pas' {SceenFrame: TFrame},
  T3dfxGridUnit in '..\MyDirectx\T3dfxGridUnit.pas',
  T3dfxVbUnit in '..\MyDirectx\T3dfxVbUnit.pas',
  T3dfxTriEditUnit in '..\MyDirectx\T3dfxTriEditUnit.pas',
  T3dfxTriCompUnit in '..\MyDirectx\T3dfxTriCompUnit.pas',
  T3dfxVertexUnit in '..\MyDirectx\T3dfxVertexUnit.pas',
  TTextureFrameUnit in '..\MyDirectx\TTextureFrameUnit.pas' {TextureFrame: TFrame},
  T3dfxVertexBufferUnit in '..\MyDirectx\T3dfxVertexBufferUnit.pas',
  T3dfxVbNormalsUnit in '..\MyDirectx\T3dfxVbNormalsUnit.pas',
  T3dfxVbPositionsUnit in '..\MyDirectx\T3dfxVbPositionsUnit.pas',
  T3dfxExtentUnit in '..\MyDirectx\T3dfxExtentUnit.pas',
  T3dfxVbTriStripeUnit in '..\MyDirectx\T3dfxVbTriStripeUnit.pas',
  T3dfxTypesUnit in '..\MyDirectx\T3dfxTypesUnit.pas',
  T3dfxVbWorldUnit in '..\MyDirectx\T3dfxVbWorldUnit.pas',
  T3dfxVbLookAtUnit in '..\MyDirectx\T3dfxVbLookAtUnit.pas',
  T3dfxVbRayUnit in '..\MyDirectx\T3dfxVbRayUnit.pas',
  T3dfxVbExtentBoxUnit in '..\MyDirectx\T3dfxVbExtentBoxUnit.pas',
  T3dfxVbShockWaveUnit in '..\MyDirectx\T3dfxVbShockWaveUnit.pas',
  T3dfxVbBulletUnit in '..\MyDirectx\T3dfxVbBulletUnit.pas',
  T3dfxVbRocketUnit in '..\MyDirectx\T3dfxVbRocketUnit.pas',
  T3dfxVbGalaxUnit in '..\MyDirectx\T3dfxVbGalaxUnit.pas',
  T3dfxVbScrapsUnit in '..\MyDirectx\T3dfxVbScrapsUnit.pas',
  T3dfxVbLineListUnit in '..\MyDirectx\T3dfxVbLineListUnit.pas',
  T3dfxGlobeUnit in '..\MyDirectx\T3dfxGlobeUnit.pas',
  T3dfxExtentBoxSimpleUnit in '..\MyDirectx\T3dfxExtentBoxSimpleUnit.pas',
  T3dfxVbExtentBoxSimpleUnit in '..\MyDirectx\T3dfxVbExtentBoxSimpleUnit.pas',
  T3dfxVbArrowUnit in '..\MyDirectx\T3dfxVbArrowUnit.pas',
  T3dfxVbTubeNormalUnit in '..\MyDirectx\T3dfxVbTubeNormalUnit.pas',
  T3dfxVbTubeTextureUnit in '..\MyDirectx\T3dfxVbTubeTextureUnit.pas',
  T3dfxStrObjUnit in '..\MyDirectx\T3dfxStrObjUnit.pas',
  T3dfxObjectFileUnit in '..\MyDirectx\T3dfxObjectFileUnit.pas',
  T3dfxCompTypeUnit in '..\MyDirectx\T3dfxCompTypeUnit.pas',
  T3dfxObjectListBaseUnit in '..\MyDirectx\T3dfxObjectListBaseUnit.pas',
  T3dfxCompObjectListUnit in '..\MyDirectx\T3dfxCompObjectListUnit.pas',
  T3dfxCompFactoryUnit in '..\MyDirectx\T3dfxCompFactoryUnit.pas',
  T3dfxCompInstUnit in '..\MyDirectx\T3dfxCompInstUnit.pas',
  T3dfxObjectChildListUnit in '..\MyDirectx\T3dfxObjectChildListUnit.pas',
  T3dfxVbSphereNormalUnit in '..\MyDirectx\T3dfxVbSphereNormalUnit.pas',
  T3dfxVbSphereTextureUnit in '..\MyDirectx\T3dfxVbSphereTextureUnit.pas',
  T3dfxVbRectNormalUnit in '..\MyDirectx\T3dfxVbRectNormalUnit.pas',
  T3dfxVbRectTextureUnit in '..\MyDirectx\T3dfxVbRectTextureUnit.pas',
  T3dfxVbBoardUnit in '..\MyDirectx\T3dfxVbBoardUnit.pas',
  T3dfxVbCubeNormalUnit in '..\MyDirectx\T3dfxVbCubeNormalUnit.pas',
  T3dfxVbCubeTextureUnit in '..\MyDirectx\T3dfxVbCubeTextureUnit.pas',
  T3dfxVbGridUnit in '..\MyDirectx\T3dfxVbGridUnit.pas',
  T3dfxMeshTextUnit in '..\MyDirectx\T3dfxMeshTextUnit.pas',
  T3dfxMeshFileUnit in '..\MyDirectx\T3dfxMeshFileUnit.pas',
  TMySettingsUnit in 'TMySettingsUnit.pas',
  TMyMenuUnit in '..\MyDirectx\TMyMenuUnit.pas',
  T3dfxScenePickUnit in '..\MyDirectx\T3dfxScenePickUnit.pas',
  T3dfxLightPointUnit in '..\MyDirectx\T3dfxLightPointUnit.pas',
  T3dfxLightSpotUnit in '..\MyDirectx\T3dfxLightSpotUnit.pas',
  T3dfxLightFlashUnit in '..\MyDirectx\T3dfxLightFlashUnit.pas',
  T3dfxRendererUnit in '..\MyDirectx\T3dfxRendererUnit.pas',
  T3dfxOcclusionBoxUnit in '..\MyDirectx\T3dfxOcclusionBoxUnit.pas',
  T3dfxVbTriangleUnit in '..\MyDirectx\T3dfxVbTriangleUnit.pas',
  T3dfxVbRaysUnit in '..\MyDirectx\T3dfxVbRaysUnit.pas',
  T3dfxProcBaseUnit in '..\MyDirectx\T3dfxProcBaseUnit.pas',
  T3dfxProcRenderUnit in '..\MyDirectx\T3dfxProcRenderUnit.pas',
  T3dfxProcAppInitUnit in '..\MyDirectx\T3dfxProcAppInitUnit.pas',
  TGenSleepUnit in '..\TGenUnits\TGenSleepUnit.pas',
  T3dfxProcMainShutDownUnit in '..\MyDirectx\T3dfxProcMainShutDownUnit.pas',
  T3dfxProcKeysUnit in '..\MyDirectx\T3dfxProcKeysUnit.pas',
  TGenOpenDialogUnit in '..\TGenUnits\TGenOpenDialogUnit.pas',
  TGenSaveAsDialogUnit in '..\TGenUnits\TGenSaveAsDialogUnit.pas',
  T3dfxProcLineEditUnit in '..\MyDirectx\T3dfxProcLineEditUnit.pas',
  T3dfxProcObjEditUnit in '..\MyDirectx\T3dfxProcObjEditUnit.pas',
  T3dfxProcObjBaseUnit in '..\MyDirectx\T3dfxProcObjBaseUnit.pas',
  T3dfxVbXyzLinesUnit in '..\MyDirectx\T3dfxVbXyzLinesUnit.pas',
  T3dfxXyxLinesUnit in '..\MyDirectx\T3dfxXyxLinesUnit.pas',
  T3dfxObjectFileIdsUnit in '..\MyDirectx\T3dfxObjectFileIdsUnit.pas',
  T3dfxDynamicUnit in '..\MyDirectx\T3dfxDynamicUnit.pas',
  T3dfxTextureUnit in '..\MyDirectx\T3dfxTextureUnit.pas',
  TGenAssertUnit in '..\TGenUnits\TGenAssertUnit.pas',
  T3dfxVertexedUnit in '..\MyDirectx\T3dfxVertexedUnit.pas',
  T3dfxBaseFactoryUnit in '..\MyDirectx\T3dfxBaseFactoryUnit.pas',
  T3dfxPrimUnit in '..\MyDirectx\T3dfxPrimUnit.pas',
  T3dfxLightFactoryUnit in '..\MyDirectx\T3dfxLightFactoryUnit.pas',
  TMyMessageFactoryUnit in '..\MyDirectx\TMyMessageFactoryUnit.pas',
  T3dfxLightContainerUnit in '..\MyDirectx\T3dfxLightContainerUnit.pas',
  TResStringUnit in 'TResStringUnit.pas',
  T3dfxConLineUnit in '..\MyDirectx\T3dfxConLineUnit.pas',
  T3dfxVbConLineUnit in '..\MyDirectx\T3dfxVbConLineUnit.pas',
  T3dfxProcConLineEditUnit in '..\MyDirectx\T3dfxProcConLineEditUnit.pas',
  T3dfxComponentUnit in '..\MyDirectx\T3dfxComponentUnit.pas',
  TMyObjActionBaseUnit in '..\MyDirectx\TMyObjActionBaseUnit.pas',
  TMyObjActionListUnit in '..\MyDirectx\TMyObjActionListUnit.pas',
  TMyObjActionFireUnit in '..\MyDirectx\TMyObjActionFireUnit.pas',
  TMyObjActionMoveUnit in '..\MyDirectx\TMyObjActionMoveUnit.pas',
  TMyObjActionRotateUnit in '..\MyDirectx\TMyObjActionRotateUnit.pas',
  TMyObjActionScaleUnit in '..\MyDirectx\TMyObjActionScaleUnit.pas',
  TMyObjActionTrackRandomUnit in '..\MyDirectx\TMyObjActionTrackRandomUnit.pas',
  TMyObjActionTrackObjUnit in '..\MyDirectx\TMyObjActionTrackObjUnit.pas',
  TMyObjActionFlashUnit in '..\MyDirectx\TMyObjActionFlashUnit.pas',
  T3dfxActionBaseUnit in '..\MyDirectx\T3dfxActionBaseUnit.pas',
  T3dfxBaseUnit in '..\MyDirectx\T3dfxBaseUnit.pas',
  TMyObjActionFactoryUnit in '..\MyDirectx\TMyObjActionFactoryUnit.pas',
  T3dfxLaserLineUnit in '..\MyDirectx\T3dfxLaserLineUnit.pas',
  T3dfxVbLaserLineUnit in '..\MyDirectx\T3dfxVbLaserLineUnit.pas',
  T3dfxChildBaseUnit in '..\MyDirectx\T3dfxChildBaseUnit.pas',
  TPropNodeUnit in '..\MyDirectx\TPropNodeUnit.pas',
  T3dfxPropBaseUnit in '..\MyDirectx\T3dfxPropBaseUnit.pas',
  T3dfxViewBaseUnit in '..\MyDirectx\T3dfxViewBaseUnit.pas',
  T3dfxDebugLineUnit in '..\MyDirectx\T3dfxDebugLineUnit.pas',
  TMyObjActionTimeUnit in '..\MyDirectx\TMyObjActionTimeUnit.pas',
  T3dfxViewPortUnit in '..\MyDirectx\T3dfxViewPortUnit.pas',
  T3dfxSceneFactoryUnit in '..\MyDirectx\T3dfxSceneFactoryUnit.pas',
  TMyFactoryBaseUnit in '..\MyDirectx\TMyFactoryBaseUnit.pas',
  TGenTimeUnit in '..\TGenUnits\TGenTimeUnit.pas',
  TTimeZoneDlgUnit in '..\MyDirectx\TTimeZoneDlgUnit.pas' {TimeZoneDlg},
  T3dfxPointFireUnit in '..\MyDirectx\T3dfxPointFireUnit.pas',
  T3dfxVbPointFireUnit in '..\MyDirectx\T3dfxVbPointFireUnit.pas',
  TGenLogUnit in '..\TGenUnits\TGenLogUnit.pas',
  TGenIniFileUnit in '..\TGenUnits\TGenIniFileUnit.pas',
  TGenShellUnit in '..\TGenUnits\TGenShellUnit.pas',
  TGenObjectUnit in '..\TGenUnits\TGenObjectUnit.pas',
  TGenTextFileUnit in '..\TGenUnits\TGenTextFileUnit.pas',
  TGenColorPickUnit in '..\TGenUnits\TGenColorPickUnit.pas' {GenColorPick},
  TGenPickFontUnit in '..\TGenUnits\TGenPickFontUnit.pas' {GenPickFont},
  TGenStrUnit in '..\TGenUnits\TGenStrUnit.pas',
  T3dfxStrUnit in '..\MyDirectx\T3dfxStrUnit.pas',
  TGenStrObjUnit in '..\TGenUnits\TGenStrObjUnit.pas',
  TMyObjActionSearchEnemyUnit in '..\MyDirectx\TMyObjActionSearchEnemyUnit.pas',
  T3dfxBeaconUnit in '..\MyDirectx\T3dfxBeaconUnit.pas',
  TMyObjActionGoHomeUnit in '..\MyDirectx\TMyObjActionGoHomeUnit.pas',
  TMyObjActionMotherShipUnit in '..\MyDirectx\TMyObjActionMotherShipUnit.pas',
  TMyObjActionBombEnemyUnit in '..\MyDirectx\TMyObjActionBombEnemyUnit.pas',
  TMyObjActionGoEnemyUnit in '..\MyDirectx\TMyObjActionGoEnemyUnit.pas',
  TMyObjActionBomberToEnemyUnit in '..\MyDirectx\TMyObjActionBomberToEnemyUnit.pas',
  TMyObjActionBaseProcUnit in '..\MyDirectx\TMyObjActionBaseProcUnit.pas',
  TTempDataBaseUnit in '..\MyDirectx\TTempDataBaseUnit.pas',
  TScoutShipDataUnit in '..\MyDirectx\TScoutShipDataUnit.pas',
  TBombShipDataUnit in '..\MyDirectx\TBombShipDataUnit.pas',
  TGenShipDataUnit in '..\MyDirectx\TGenShipDataUnit.pas',
  TGenAmmoDataUnit in '..\MyDirectx\TGenAmmoDataUnit.pas',
  TMyObjActionDockShipUnit in '..\MyDirectx\TMyObjActionDockShipUnit.pas',
  TMyObjActionLaunchShipUnit in '..\MyDirectx\TMyObjActionLaunchShipUnit.pas',
  TMotherShipDataUnit in '..\MyDirectx\TMotherShipDataUnit.pas',
  TGenBeaconDataUnit in '..\MyDirectx\TGenBeaconDataUnit.pas',
  TMyObjActionMotherBombEnemyUnit in '..\MyDirectx\TMyObjActionMotherBombEnemyUnit.pas',
  T3dfxVbBeaconUnit in '..\MyDirectx\T3dfxVbBeaconUnit.pas',
  TMyObjActionGenShipProcUnit in '..\MyDirectx\TMyObjActionGenShipProcUnit.pas',
  TMotherLaunchedShipUnit in '..\MyDirectx\TMotherLaunchedShipUnit.pas';

{$R DirectX7Project.res}

{$IFDEF DEFDEBUG}
var
  a : integer;
{$ENDIF}
begin

  MyTime := TGenTime.Create(true);

  // Start Loging first

  TGenLog.Startup(nil);

  TGenClasses.AddSearchFolder('E:\My Projects\Grape');
  TGenClasses.AddSearchFolder('E:\My Projects\MyDirectx');
  TGenClasses.AddSearchFolder('E:\My Projects\TGenUnits');

{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  StrStartUp;
  ObjectFactory.SetClassNames;
  
  // Initialize the Application Object (Wont do a thing)

  Application.Initialize;
  Application.Title := '';

  // Load all Application Settings

  TMySettings.AppSettingsStartup;

{$IFDEF DEFDEBUG}
  LogMemToFile;
{$ENDIF}

  // Startup Message Qeue

  TMyMessageFactory.StartUp;

{$IFDEF DEFDEBUG}
  LogMemToFile;

  // Create Main Form

  LogToFile('');
  LogToFile(TGrapeMain.ClassName + resLogCreate + ':');
{$ENDIF}

  Application.CreateForm(TGrapeMain, GrapeMain);
  // Run Application

  Application.Run;

{$IFDEF DEFDEBUG}
  a := AllocMemSize;
{$ENDIF}

  TMySettings.AppSettingsShutDown;

{$IFDEF DEFDEBUG}
  LogToFile('', AllocMemSize - a);
  LogMemToFile;

  a := AllocMemSize;
{$ENDIF}

  // ShutDown Message Qeue

  TMyMessageFactory.ShutDown;

{$IFDEF DEFDEBUG}
  LogToFile('', AllocMemSize - a);
  LogMemToFile;
{$ENDIF}

  TMyObjActionFactory.ShutDown;

{$IFDEF DEFDEBUG}

  LogToFile('');
  LogToFile('Main Ending' + resLogShutDown + CLN);

    LogToFile(FixLenStrB('  T3dfxBase Count', DebugLineWdt) +
              IntToStr(T3dfxBase.GetObjectsDebugCount));

    LogToFile(FixLenStrB('  T3dfxBase Max', DebugLineWdt) +
              IntToStr(T3dfxBase.GetObjectsDebugCountMax));

    LogToFile(FixLenStrB('  T3dfxExt Count', DebugLineWdt) +
              IntToStr(T3dfxExtent.GetDebugCount));

    LogToFile(FixLenStrB('  T3dfxHit Count', DebugLineWdt) +
              IntToStr(T3dfxHit.GetDebugCount));

    LogToFile(FixLenStrB('  T3dfxVertex Count', DebugLineWdt) +
              IntToStr(T3dfxVertex.GetDebugCount));

    LogToFile(FixLenStrB('  T3dfxVertexList Count', DebugLineWdt) +
              IntToStr(T3dfxVertexList.GetDebugCount));

    LogToFile(FixLenStrB('  T3dfxVertexBuffer Count', DebugLineWdt) +
              IntToStr(T3dfxVertexBuffer.GetDebugCount));

    LogToFile(FixLenStrB('  TTempDataBase Count', DebugLineWdt) +
              IntToStr(TTempDataBase.GetDebugCount));

    // If not 0 then a Drawing Object is dangling

    if (T3dfxBase.GetObjectsDebugCount <> 0) then
      LogErrorToFile('Object Count is not Zero: ' +
              IntToStr(T3dfxBase.GetObjectsDebugCount));

    // Check on T3dfxExtent

    if (T3dfxExtent.GetDebugCount <> 0) then
      LogErrorToFile('T3dfxExt Count is not Zero: ' +
              IntToStr(T3dfxExtent.GetDebugCount));

    // Check on TTempDataBase

    if (TTempDataBase.GetDebugCount <> 0) then
      LogErrorToFile('TTempDataBase Count is not Zero: ' +
              IntToStr(TTempDataBase.GetDebugCount));

  LogToFile('');
  LogToFile('TGenObject' + resLogShutDown + CLN);
  LogToFile(FixLenStrB('  TGenObject Count', DebugLineWdt) +
                  IntToStr(TGenObject.GetDebugCount));

  LogToFile(FixLenStrB('  TGenObject Max', DebugLineWdt) +
                  IntToStr(TGenObject.GetDebugMaxCount));

  LogToFile(FixLenStrB('  TDebugObjectList Count', DebugLineWdt) +
                  IntToStr(TDebugObjectList.GetDebugCount));

  LogToFile(FixLenStrB('  TDebugObjectList Max', DebugLineWdt) +
                  IntToStr(TDebugObjectList.GetDebugMaxCount));

  LogToFile(FixLenStrB('  TMyTextFile Count', DebugLineWdt) +
                  IntToStr(TGenTextFile.GetDebugCount));
{$ENDIF}

  MyTime.Free;

  if (TGenTime.GetDebugCount <> 0) then
            LogErrorToFile('TGenTime Count is not Zero: ' +
                  IntToStr(TGenTime.GetDebugCount));

  if (TGenObject.GetDebugCount <> 0) then
            LogErrorToFile('TGenObject Count is not Zero: ' +
                  IntToStr(TGenObject.GetDebugCount));

  if (TDebugObjectList.GetDebugCount <> 0) then
            LogErrorToFile('TDebugObjectList Count is not Zero: ' +
                  IntToStr(TDebugObjectList.GetDebugCount));

  StrShutDown;

  // As last thing, shutdown Logging

  TGenLog.ShutDown;
  
{$IFDEF DEFDEBUG}
  LogLastMemToFile(' Project End');
{$ENDIF}
end.
