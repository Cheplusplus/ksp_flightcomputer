//Helper Functions

FUNCTION lngTOdeg {
	PARAMETER lng.
	
	RETURN MOD((lng + 360), 360).
}.

FUNCTION closeToo {
	PARAMETER a, b, degree.
	
	IF a >= b - degree AND a <= b + degree {
	RETURN TRUE.
	}.
}.