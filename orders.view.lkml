view: orders {
  sql_table_name: public.orders ;;

  dimension: id {
#     primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: ${id} || '' || ${created_raw} ;;
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

  dimension: days_as_user {
    type: number
    sql: datediff('days',${users.created_raw},${created_raw}) ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, users.id, users.first_name, users.last_name, order_items.count]
  }
}
