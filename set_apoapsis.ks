//SET APOAPSIS

RUNPATH(control_functions).
RUNPATH(helper_functions).

PARAMETER maxAlt.

IF maxAlt > ALTITUDE {

	UNTIL closeToo(APOAPSIS, maxAlt, 100) {
	ctrlBurn(PROGRADE, APOAPSIS, maxAlt, 1).
	}.
}. ELSE {
	
	UNTIL closeToo(PERIAPSIS, maxAlt, 100) {
	ctrlBurn(RETROGRADE, PERIAPSIS, maxAlt, 0).

	}.
}.

LOCK THROTTLE TO 0.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.