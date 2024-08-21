/obj/item/gun/energy/event_horizon
	name = "\improper Event Horizon anti-existential beam rifle"
	desc = "Nanotrasen developed experimental weapons platform for accelerating heated sub-atomic particles at near-lightspeed by utilizing a\
	blackhole generator to accelerate them past an immense gravitational field. Keep your fingers away from the barrel during firing.\
	Might cause unexpected spaggetification"

/obj/projectile/beam/event_horizon
	damage = HUMAN_HEALTH_MODIFIER * 100
	damage_type = BRUTE
	armor_flag = ENERGY
	range = 150
	jitter = 5 SECONDS
