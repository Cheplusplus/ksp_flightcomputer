//Control Functions

FUNCTION pTHROTTLE {
	PARAMETER first, second, direction.
	
	IF direction = "1" {
	
		SET diff TO first - second.
	}. ELSE {
			SET diff TO second - first.
		}.

	IF diff < 5{
		SET pThrot TO diff * 0.1.
		SET pThrot TO MAX(0, MIN(pThrot, 1)).
		LOCK THROTTLE TO pThrot.
	}. ELSE {
		LOCK THROTTLE TO 1.
	}.
}.

FUNCTION ctrlBurn {
	PARAMETER direction,  v1, v2, dir is "1". 
	
	SET prevTHRUST to MAXTHRUST.
	LOCK STEERING TO direction.
	pTHROTTLE(v2,v1, dir).
	RUNPATH(stage_check, prevTHRUST).
}.

FUNCTION exeCirc {
	PARAMETER direction.
	
	LOCK THROTTLE TO 0.
	PANELS ON.
	RUNPATH (circularize, direction).
}.