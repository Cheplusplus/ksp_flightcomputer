//STAGE CHECK

PARAMETER prevTHRUST is 0.

IF MAXTHRUST < (prevTHRUST - 10) {
	SET currentThrottle TO THROTTLE.
	LOCK THROTTLE TO 0.
	WAIT 0.5. STAGE. WAIT 0.2.
	LOCK THROTTLE TO currentThrottle.
	SET prevTHRUST to MAXTHRUST.
}.