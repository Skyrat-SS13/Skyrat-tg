////////////////////////////
/// LIVING LATEX CLOTHES ///
////////////////////////////


/// Тело:
// Модуль липкости. Не позволяет пользователю покинуть объекты, к которым он прикован без посторонней помощи. После определенного промежутка времени, пользователь может покинуть объект с долгим к/д. Не может вырваться из хватки любого уровня.
/obj/item/clothing/suit/ll_stickybody
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Модуль чувствительности. Каждое взаимодействие с пользователем, будет сопровождаться щекоткой
/obj/item/clothing/suit/ll_sensetivebody
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Ноги:
// Обычные носочки с раздельными пальцами. (DEFAULT)
/obj/item/clothing/shoes/ll_socks
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Каблуки, замедляющие ходьбу и издающие цокающие звуки.
/obj/item/clothing/shoes/ll_heels
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Надувные шары, которые издают скрипящие звуки и с случайным шансом роняют пользователя на пол. Замедляют.
/obj/item/clothing/shoes/ll_creakingballs
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Ботинки, накидывающие эфект щекотки при ходьбе.
/obj/item/clothing/shoes/ll_ticklingboots
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Связывающие в коленях штуки.
/obj/item/clothing/shoes/ll_kneecord
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


/// Руки:
// Перчатки (DEFAULT)
/obj/item/clothing/gloves/ll_gloves
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Надувные рукавицы, делающие руки бесполезными.
/obj/item/clothing/gloves/ll_inflateblegloves
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Маска:
// Ничего (DEFAULT)
// Кляп, заполняющий ротовую полость, питающий носителя, но снижающий уровень психического здоровья
/obj/item/clothing/mask/ll_feedinggag
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Противогаз, постоянно накачивающий носителя кроцином и питательными веществами, но снижающий уровень психического здоровья
/obj/item/clothing/mask/gas/ll_feedenggasmask
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Шлем:
// Ничего (DEFAULT)
// Закрывающий волосы капюшон и крепко прилегающий к голове
/obj/item/clothing/head/helmet/ll_hood
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Пах:
// Ничего (DEFAULT)
// Присоски, которые постоянно удерживают цель на грани и повышают возбуждения до максимума.
/obj/item/clothing/ll_arrousalsuckers
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''
	slot_flags = ITEM_SLOT_VAGINA | ITEM_SLOT_ANUS | ITEM_SLOT_PENIS
	var/mutantrace_variation = NO_MUTANTRACE_VARIATION

//For correct work we need to use one slot for one instance of the object
/obj/item/clothing/ll_arrousalsuckers/Initialize(new_slot_flags = ITEM_SLOT_VAGINA | ITEM_SLOT_ANUS | ITEM_SLOT_PENIS)
	. = ..()
	slot_flags = new_slot_flags



/// Грудь:
// Ничего (DEFAULT)
// Тентакли, разминающие эту часть тела и повышающие настроение цели, однако снижающие скорость передвижения.
/obj/item/clothing/suit/ll_tentacles
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Ошейник:
// Мягкий надувной ошейник, закрепляющий костюм на персонаже (DEFAULT)
/obj/item/clothing/neck/ll_softinflatablecollar
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Ошейник, не позволяющий пользователю взаимодействовать с вещами в ЕРП слотах.
/obj/item/clothing/neck/ll_erpslotblockcollar
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''



/// Очки:
// Очки, накладывающие эффект влюбленности в первого обнявшего пользователя человека (Механ зелья любви из ксенобиологии. Смотри заряженный розовый экстракт)
/obj/item/clothing/glasses/ll_lovinggoggles
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''


// Гипноочки
/obj/item/clothing/glasses/ll_hypnogoggles
	name = ""
	desc = ""
	icon_state = ""
	inhand_icon_state = ""
	// icon = ''
	// worn_icon = ''
	// worn_icon_digi = ''
	// worn_icon_taur_hoof = ''
	// worn_icon_taur_paw = ''
	// worn_icon_taur_snake = ''
