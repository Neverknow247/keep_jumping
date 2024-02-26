extends Node
class_name Steam_Client

signal received_results(result)

var AppID = "480"
var logged_in_user
var leaderboard_handle
var level_id_board

func _init():
	OS.set_environment("SteamAppID",AppID)
	OS.set_environment("SteamGameID",AppID)
	Steam.leaderboard_find_result.connect(_on_leaderboard_find_result)
	Steam.leaderboard_score_uploaded.connect(_on_leaderboard_score_uploaded)
	Steam.leaderboard_scores_downloaded.connect(_on_leaderboard_scores_downloaded)
	Steam.file_write_async_complete.connect(_on_file_write_async_complete)
	Steam.file_share_result.connect(_on_file_share_result)
	#Steam.setLeaderboardDetailsMax(5000)

func _ready():
	Steam.steamInit()
	var isRunning = Steam.isSteamRunning()
	
	if !isRunning:
		print("Error: Steam Not Running")
		return

	print("Steam is Running")
	var id = Steam.getSteamID()
	var name = Steam.getFriendPersonaName(id)
	print("Username: ", str(name))
	logged_in_user = str(name)
	#Steam.findLeaderboard("level_1_1")

func _process(delta):
	Steam.run_callbacks()

func setAchievement(ach):
	var status = Steam.getAchievement(ach)
	if status["achieved"]:
		print("Already Unlocked")
		return
	Steam.setAchievement(ach)
	print("Unlocked Achievment: ",ach)

func find_leaderboard(handle):
	Steam.findLeaderboard(handle)

func _on_leaderboard_find_result(handle: int, found: int) -> void:
	if found == 1:
		leaderboard_handle = handle
		print("Leaderboard handle found: %s" % leaderboard_handle)
	else:
		print("No handle was found")

func _on_leaderboard_score_uploaded(success: int, this_handle: int, this_score: Dictionary) -> void:
	if success == 1:
		print("Successfully uploaded scores! Score: ", this_score)
	else:
		print("Failed to upload scores!")

func download_leaderboard(from = 0, to = 1000):
	Steam.downloadLeaderboardEntries(from,to,)

func _on_leaderboard_scores_downloaded(message,handle,result):
	print("received_result")
	received_results.emit(result)
	#print(message,handle,result)
	

func _on_file_write_async_complete(m_eResult):
	print(m_eResult)
	if m_eResult:
		Steam.fileShare(level_id_board)
	else:
		print("failed")

func _on_file_share_result(m_eResult,m_hFile,m_rgchFilename):
	print("9999")
	print(m_eResult)
	print(m_hFile)
	print(m_rgchFilename)
	print("9999")
	Steam.attachLeaderboardUGC(m_hFile)
