CrawlerMaster
=============

你的爬蟲大統領（or something）

-----------------

## TODOs

* index => 列出所有的 crawlers
  - [*] endpoint: /crawlers
  - [ ] show last_run_at
  - [x] show running workers in queue (Sidekiq::Queue find class name)
  - [ ] show how many courses each crawler had done

* show => 顯示單一爬蟲的資訊 name / crawling status
  - [*] endpoint: /crawlers/ntust, /crawler/{school name}
  - [ ] alias as "dashboard" endpoint :p
  - [ ] track each worker job progress and status
  - [ ] Start crawler anytime => track job ids
  - [ ] ScheduledSet / RetrySet / DeadSet status (filtered by class name)
  - [ ] Limiting queueing crawler (eg. each class for 5 instances)

* setting => 設定單一爬蟲的 api secrets / retry interval / scheduling
  - [ ] endpoint: /crawlers/{school name}/setting (edit page)
  - [ ] understanding sidekiq scheduler usage and parameters
  - [ ] Schedule crawler (whenever, .etc)
  - [ ] initializer setup existing scheduling behavior

* Course Model
  - [ ] Copy and Paste from Colorgy/Core :p
  - [ ] Check data integrity (no blank class name / no blank class period data / no invalid period data......)
  - [ ] Check course_code
  - [ ] Sync data to Core

* 後期調教
  - [ ] Redis Namespace
  - [*] queue namespace(Sidekiq::Client push specific queue name)
  - [ ] Limiting retry count
  - [ ] limit queue number
  - [*] we can't kill workers orz
  - [ ] sidekiq-limit_fetch set limit

```ruby
Sidekiq::Client.push('queue' => 'NtustCourseCrawler', 'class' => CourseCrawler::Worker, 'args' => ['NtustCourseCrawler'])
```

* 有閒套個 AdminLTE 吧 ww
