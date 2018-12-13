// CIRCULARIZE

RUNPATH(control_functions).
RUNPATH(helper_functions).

PARAMETER direction is "prograde".
SET prevTHRUST to MAXTHRUST.

IF direction = "prograde" {

	LOCK STEERING TO PROGRADE.
	WAIT UNTIL ETA:APOAPSIS < 2.
	SET x TO ((constant:G * KERBIN:MASS) / (KERBIN:RADIUS + ALTITUDE ))^0.5.

	UNTIL closeToo(SHIP:VELOCITY:ORBIT:MAG, x, 0.01) {
		ctrlBurn(PROGRADE, SHIP:VELOCITY:ORBIT:MAG, x, 1).
	}.
}. ELSE IF direction = "reverse" {

		LOCK STEERING TO RETROGRADE.
		WAIT UNTIL ETA:PERIAPSIS < 2.
		SET x TO ((constant:G * KERBIN:MASS) / (KERBIN:RADIUS + ALTITUDE ))^0.5.

		UNTIL closeToo(SHIP:VELOCITY:ORBIT:MAG, x, 0.01) {
			ctrlBurn(RETROGRADE, SHIP:VELOCITY:ORBIT:MAG, x, 0).
		}.
	}.
	
LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
PANELS ON.



