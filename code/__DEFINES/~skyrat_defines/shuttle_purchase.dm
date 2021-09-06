//Types of shuttles as bitflags
#define SHUTTLE_CIV (1<<0)
#define SHUTTLE_MINING (1<<1)
#define SHUTTLE_EXPLORATION (1<<2)
#define SHUTTLE_ARMED (1<<3)
#define SHUTTLE_ILLEGAL (1<<4)
#define LEGAL_SHUTTLE_TYPES (SHUTTLE_CIV|SHUTTLE_MINING|SHUTTLE_EXPLORATION|SHUTTLE_ARMED)
#define ALL_SHUTTLE_TYPES (LEGAL_SHUTTLE_TYPES|SHUTTLE_ILLEGAL)

#define DOCKS_SMALL_UPWARDS "smalldock" = TRUE, "mediumdock" = TRUE, "largedock" = TRUE, "hugedock" = TRUE
#define DOCKS_MEDIUM_UPWARDS "mediumdock" = TRUE, "largedock" = TRUE, "hugedock" = TRUE
#define DOCKS_LARGE_UPWARDS "largedock" = TRUE, "hugedock" = TRUE
#define DOCKS_HUGE_UPWARDS "hugedock" = TRUE
