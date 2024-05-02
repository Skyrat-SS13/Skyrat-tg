/// A function that exponentially approaches a maximum value of L
/// k is the rate at which it approaches L, x_0 is the point where the function = 0
#define LOGISTIC_FUNCTION(L,k,x,x_0) (L/(1+(NUM_E**(-k*(x-x_0)))))
