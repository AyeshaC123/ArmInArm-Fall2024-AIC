json.extract! admin_panel, :id, :appointment_length, :max_appointment_count, :booking_days, :service_time, :created_at, :updated_at
json.url admin_panel_url(admin_panel, format: :json)
