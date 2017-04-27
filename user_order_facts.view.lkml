view: user_order_facts {
  derived_table: {
    sql: select
        users.id as id,
        count(*) as lifetime_orders,
        max(orders.created_at) as last_order_date,
        min(orders.created_at) as first_order_date
      from users
      left join orders on users.id = orders.user_id
      group by 1
       ;;
    sortkeys: ["id"]
    distribution: "id"
    sql_trigger_value: select current_date ;;

  }

  measure: count {
    type: count
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: lifetime_orders {
    type: number
    sql: ${TABLE}.lifetime_orders ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [raw,date,month,week, year]
    sql: ${TABLE}.last_order_date ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [raw,date,month,week, year]
    sql: ${TABLE}.first_order_date ;;
  }

}
