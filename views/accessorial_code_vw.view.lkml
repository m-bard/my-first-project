view: accessorial_code_vw {
  sql_table_name: POC_LOOKER_DATAHUB.ACCESSORIAL_CODE_VW ;;

  dimension: accessorial_code_id {
    type: number
    sql: ${TABLE}.ACCESSORIAL_CODE_ID ;;
  }

  dimension: accessorial_desc {
    type: string
    sql: ${TABLE}.ACCESSORIAL_DESC ;;
  }

  dimension: generic_accessorial_code {
    type: string
    sql: ${TABLE}.GENERIC_ACCESSORIAL_CODE ;;
  }

  dimension: generic_accessorial_desc {
    type: string
    sql: ${TABLE}.GENERIC_ACCESSORIAL_DESC ;;
  }

  dimension_group: last_updated {
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
    sql: CAST(${TABLE}.LAST_UPDATED_DATE AS TIMESTAMP) ;;
  }

  dimension: specific_accessorial_code {
    type: string
    sql: ${TABLE}.SPECIFIC_ACCESSORIAL_CODE ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
