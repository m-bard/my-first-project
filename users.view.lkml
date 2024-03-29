view: users {
  sql_table_name: demo_db.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
    style: integer
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name},' ',${last_name}) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_over_21 {
    type: count
    filters: {
      field: age
      value: ">21"
    }
  }

  measure: average_age {
    type: average
    sql:  ${age} ;;
    value_format_name: decimal_2
  }

  measure: highest_age {
    type: max
    sql: ${age} ;;
    html: <b>{{rendered_value}}</b> ;;
  }

  measure: lowest_age {
    type: min
    sql: ${age} ;;
  }

  measure: age_span {
    type: number
    sql: ${highest_age} - ${lowest_age} ;;
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      first_name,
      last_name,
      events.count,
      orders.count,
      user_data.count
    ]
  }
}
