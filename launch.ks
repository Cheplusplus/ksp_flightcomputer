


FUNCTION ACCENT_PROFILE {
	PARAMETER minAlt.
	PARAMETER minAngle.
	PARAMETER newThrot.
	PARAMETER direction.
	SET prevTHRUST to MAXTHRUST.

	UNTIL FALSE {
		RUNPATH(stage_check).
		IF ALTITUDE > minAlt {
		
		LOCK THROTTLE TO newThrot.
		LOCK STEERING TO HEADING (direction, minAngle).
		BREAK.
		}.
	}.
	WAIT 0.1.
}.

FUNCTION EXECUTE_ACCENT_PROFILE {
	PARAMETER profile.
	PARAMETER direction.
	
	SET step TO 0.
	UNTIL step >= profile:length {
		ACCENT_PROFILE(profile[step],
						profile[step + 1],
						profile[step + 2],
						direction).
		SET step TO (step + 3).
	}.
}.


RUNPATH (launch_profile).
STAGE.
EXECUTE_ACCENT_PROFILE(profile, 90).
RUNPATH (set_apoapsis, 200000).
RUNPATH(circularize).
//RUNPATH(inclination_correct).
//RUNPATH(rendevouz,0 ,"GE").
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
//RUNPATH (deorbit).


