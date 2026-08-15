CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanCaveB1FTrainerHeaders
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

CeruleanCaveB1F_ScriptPointers:
	def_script_pointers
	dw_const CeruleanCaveDefaultScript,              SCRIPT_CERULEANCAVEB1F_DEFAULT
	dw_const DisplayEnemyTrainerTextAndStartBattle, SCRIPT_CERULEANCAVEB1F_START_BATTLE
	dw_const EndTrainerBattle,                      SCRIPT_CERULEANCAVEB1F_END_BATTLE

CeruleanCaveDefaultScript:
	CheckEventHL EVENT_BEAT_MEWTWO
	jp nz, CheckFightingMapTrainers
	CheckEventReuseHL EVENT_FIGHT_MEWTWO
	ResetEventReuseHL EVENT_FIGHT_MEWTWO
	jp z, CheckFightingMapTrainers
	SetEvent EVENT_BEAT_MEWTWO
	ld a, TOGGLE_MR_FUJIS_HOUSE_MR_FUJI
	ld [wToggleableObjectIndex], a
	predef HideObject
	ld a, TOGGLE_POKEMON_TOWER_7F_MR_FUJI
	ld [wToggleableObjectIndex], a
	predef ShowObject
	ld a, TEXT_CERULEANCAVEB1F_MEWTWO_POST
	ldh [hTextID], a
	call DisplayTextID
	call Delay3
	ret

CeruleanCaveB1F_TextPointers:
	def_text_pointers
	dw_const CeruleanCaveB1FMewtwoText, TEXT_CERULEANCAVEB1F_MEWTWO
	dw_const PickUpItemText,            TEXT_CERULEANCAVEB1F_ULTRA_BALL
	dw_const PickUpItemText,            TEXT_CERULEANCAVEB1F_MAX_REVIVE
	dw_const CeruleanCaveB1FMewtwoPostText,		TEXT_CERULEANCAVEB1F_MEWTWO_POST

CeruleanCaveB1FTrainerHeaders:
	def_trainers
MewtwoTrainerHeader:
	trainer EVENT_FIGHT_MEWTWO, 0, MewtwoBattleText, MewtwoBattleText, MewtwoBattleText
	db -1 ; end

CeruleanCaveB1FMewtwoText:
	text_asm
	ld hl, MewtwoTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MewtwoBattleText:
	text_far _MewtwoBattleText
	text_asm
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

CeruleanCaveB1FMewtwoPostText:
	text_far _CeruleanCaveB1FMewtwoPostText
	text_end
