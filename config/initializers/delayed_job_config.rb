Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.max_attempts = 3
Delayed::Worker.sleep_delay = 10
Delayed::Worker.max_run_time = 3.minutes
Delayed::Worker.delay_jobs = !Rails.env.test?
