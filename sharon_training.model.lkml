connection: "red_look"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: users {
  view_name: users
  join: orders {
    type: left_outer
    relationship: one_to_many
    sql_on: ${users.id} = ${orders.user_id} ;;
  }
  join: order_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${orders.id} = ${order_items.order_id} ;;
  }
 join: user_order_facts {
   type: inner
  relationship: one_to_one
  sql_on: ${users.id} = ${user_order_facts.id} ;;
 }
}

explore: inventory_items {}
