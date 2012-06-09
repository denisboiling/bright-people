#OPTIMIZE:
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.sleep_delay = 10
Delayed::Worker.max_attempts = 3
Delayed::Worker.max_run_time = 5.minutes
# Nice trick to don't start delayed_job of test env
Delayed::Worker.delay_jobs = !Rails.env.test?
