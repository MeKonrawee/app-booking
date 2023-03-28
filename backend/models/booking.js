class BookingResponse {
  constructor(
    id,
    food_menu,
    full_name,
    person_number,
    table_number,
    tel,
    date,
    total_price,
    average_calories
  ) {
    this.id = id;
    this.food_menu = food_menu;
    this.full_name = full_name;
    this.person_number = person_number;
    this.table_number = table_number;
    this.tel = tel;
    this.date = date;
    this.total_price = total_price;
    this.average_calories = average_calories;
  }
}

module.exports = BookingResponse;
