//Orbital rendevouz

RUNPATH(control_functions).
RUNPATH(helper_functions).

//This files parameters.

PARAMETER offset.  //The offset angle for the rendevouz.
PARAMETER targetVessel.  //the vessel or body to rendevouz with.

	SET TARGET TO 						targetVessel.
	SET sgp TO 							CONSTANT:G * KERBIN:MASS.
	SET targetPeriod TO 				TARGET:ORBIT:PERIOD.
	SET semimajoraxis TO				((TARGET:ALTITUDE + ALTITUDE ) + (2 * KERBIN:RADIUS)) / 2.
	SET tTime TO  				 		((2 * CONSTANT:PI) * ((semimajoraxis)^3 / sgp)^0.5) / 2.         
	SET tAngle TO  						180 - ((tTime / targetPeriod) * 360).
	
	IF ALTITUDE > TARGET:ALTITUDE {
		SET tAngle TO (0 - tAngle).
	}.
	
	SET lngDiff TO 0.
	PRINT tAngle AT (0, 28).
	
UNTIL tAngle - 0.1 < lngDiff AND lngDiff < tAngle + 0.1 {

	SET lngDiff TO (lngTOdeg(SHIP:LONGITUDE) - lngTOdeg(TARGET:LONGITUDE)).
	IF lngDiff > 180 {
	SET lngDiff TO lngDiff - 360.
	}.
	PRINT lngDiff AT (0, 29).
	WAIT 0.1.
}.


SET prevTHRUST to MAXTHRUST.

IF tAngle > 0 {
	LOCK STEERING TO RETROGRADE.
	WAIT 2.
	UNTIL closeToo(PERIAPSIS, TARGET:ALTITUDE, 100) {
		ctrlBurn(RETROGRADE, PERIAPSIS, TARGET:ALTITUDE, 0).	
	}.
	exeCirc("RETROGRADE").
}. ELSE {
	LOCK STEERING TO PROGRADE.
	WAIT 2.
	UNTIL closeToo(APOAPSIS, TARGET:ALTITUDE, 100) {
	
		ctrlBurn(PROGRADE, APOAPSIS, TARGET:ALTITUDE, 1).
	}.
	exeCirc("PROGRADE").
}.



