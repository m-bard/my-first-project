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
    value_format_name: usd
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

  dimension: price_range_color_coded {
    type: string
    sql: ${price_range} ;;
    html:
      {% if value == "Inexpensive" %}
        <p style="color: green">{{ value }}</p>
      {% elsif value == "Moderate" %}
        <p style="color: yellow">{{ value }}</p>
      {% else %}
        <p style="color: red">{{ value }}</p>
      {% endif %} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
  }

  measure: order_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: highest_price {
    type: max
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: median_price {
    type: median
    sql: ${sale_price} ;;
    value_format_name: usd
  }
}
