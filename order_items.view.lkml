view: order_items {
  sql_table_name: demo_db.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension: price_range {
    case: {
      when: {
        sql: ${sale_price} < 25 ;;
        label: "Inexpensive"
      }
      when: {
        sql: ${sale_price} >= 25 AND ${sale_price} < 75 ;;
        label: "Moderate"
      }
      else: "Expensive"
    }
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }
}
