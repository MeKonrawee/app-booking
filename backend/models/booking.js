class BookingResponse {
  constructor(
    id,
    food_menu,
    full_name,
    person_number,
    table_number,
    tel,
    date,
    quantity
  ) {
    this.id = id;
    this.food_menu = food_menu;
    this.full_name = full_name;
    this.person_number = person_number;
    this.table_number = table_number;
    this.tel = tel;
    this.date = date;
    this.quantity = quantity;
  }
}

module.exports = BookingResponse;
