Delayed::Backend::ActiveRecord::Job.create!([
  {id: 1, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 1968d2de-a12f-451f-a5e7-1c4f62b7a90c\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - Reviewer\n", last_error: nil, run_at: "2015-11-08 01:21:26", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 2, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: d38bd81b-8d80-4cce-9e06-182ab513c43d\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - Review\n", last_error: nil, run_at: "2015-11-08 01:21:26", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 3, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 3bde23d3-d5e6-4996-89ff-659743ad0f84\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - Approver\n", last_error: nil, run_at: "2015-11-08 01:21:26", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 4, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: e6656ed2-5d96-4747-ae25-9776dcdafa4b\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - User\n", last_error: nil, run_at: "2015-11-08 01:21:26", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 5, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: dee007dd-4ab5-4ada-8b3c-adc0cf0f608a\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - Approval\n", last_error: nil, run_at: "2015-11-08 01:25:24", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 6, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 9a236e76-9af6-4a95-9984-ca6c99a7d1b1\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - daniel.yuft@gmail.com\n  - Sign off\n", last_error: nil, run_at: "2015-11-08 01:25:31", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 7, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: ad1a2f1f-278d-4377-bd70-f75ebdcb1c32\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - doc_status\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Review of SOPs\n  - Approved\n", last_error: nil, run_at: "2015-11-08 01:25:32", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 8, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: dd1f3a18-1089-4e47-9096-bc912fc82184\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - Reviewer\n", last_error: nil, run_at: "2015-11-08 01:26:15", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 9, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 672172ee-1e9e-4011-98d0-24a448603e78\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - Review\n", last_error: nil, run_at: "2015-11-08 01:26:15", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 10, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: ead1afe9-7b78-44c8-8fca-30984c868a3e\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - Approver\n", last_error: nil, run_at: "2015-11-08 01:26:15", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 11, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 1ce39313-2816-4aa8-a4c5-c64f8b82bd4b\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - assign_role\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - User\n", last_error: nil, run_at: "2015-11-08 01:26:15", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 12, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: de9958d3-e656-47fa-adf6-ba2779dd3971\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - Approval\n", last_error: nil, run_at: "2015-11-08 01:26:26", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 13, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 86d55cdf-d756-4bff-bfc3-3aa2148efb18\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - do_action\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - daniel.yuft@gmail.com\n  - Sign off\n", last_error: nil, run_at: "2015-11-08 01:26:33", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"},
  {id: 14, priority: 0, attempts: 0, handler: "--- !ruby/object:ActiveJob::QueueAdapters::DelayedJobAdapter::JobWrapper\njob_data:\n  job_class: ActionMailer::DeliveryJob\n  job_id: 0a6df4bf-363e-4a4d-84be-593eb7e5c056\n  queue_name: mailers\n  arguments:\n  - Notifier\n  - doc_status\n  - deliver_now\n  - daniel.yuft@gmail.com\n  - Pharmacist Absence\n  - Approved\n", last_error: nil, run_at: "2015-11-08 01:26:33", locked_at: nil, failed_at: nil, locked_by: nil, queue: "mailers"}
])
User.create!([
  {id: 1, password: "12345678", doc_file_name: nil, doc_content_type: nil, doc_file_size: nil, doc_updated_at: nil, email: "daniel.yuft@gmail.com", encrypted_password: "$2a$10$xdcCzz0ZGQSV8dGs9L6qa.Y6bNAmFKZTpowK4OgczcH.IoWJVmlV2", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 5, current_sign_in_at: "2015-11-08 01:07:18", last_sign_in_at: "2015-11-06 00:00:28", current_sign_in_ip: "::1", last_sign_in_ip: "::1", last_seen_at: "2015-11-08 01:26:47", name: "Daniel"}
])
Approval.create!([
  {id: 1, status: 1, document_id: 1, user_id: 1, major_version: 0, minor_version: 1},
  {id: 2, status: 1, document_id: 2, user_id: 1, major_version: 0, minor_version: 1}
])
Review.create!([
  {id: 1, status: 1, document_id: 1, user_id: 1, major_version: 0, minor_version: 1},
  {id: 2, status: 1, document_id: 2, user_id: 1, major_version: 0, minor_version: 1}
])
Document.create!([
  {id: 1, title: "Review of SOPs", status: 3, content: "<p>tester123</p>", assigned_to_all: nil, user_id: 1, organisation_id: 1, document_type_id: nil, doc_file_name: nil, doc_content_type: nil, doc_file_size: nil, doc_updated_at: nil, major_version: "1", minor_version: "0", do_update: true, change_control: "Initial creation.", review_date: "2015-11-08", document_topic_id: nil, topic_id: 4},
  {id: 2, title: "Pharmacist Absence", status: 3, content: "<p>test323234</p>", assigned_to_all: nil, user_id: 1, organisation_id: 1, document_type_id: nil, doc_file_name: nil, doc_content_type: nil, doc_file_size: nil, doc_updated_at: nil, major_version: "1", minor_version: "0", do_update: true, change_control: "Initial creation.", review_date: "2015-11-08", document_topic_id: nil, topic_id: 5}
])
DocumentRevision.create!([
  {id: 1, major_version: 0, minor_version: 1, content: "<p>tester123</p>", change_control: "Initial creation.", document_id: 1},
  {id: 2, major_version: 0, minor_version: 1, content: "<p>test323234</p>", change_control: "Initial creation.", document_id: 2}
])
Organisation.create!([
  {id: 1, name: "default_pharmacy", user_id: nil, gms_code: "0000000"}
])
OrganisationUser.create!([
  {id: 1, accepted: true, user_type: 2, user_id: 1, organisation_id: 1, inviter_id: 1}
])
RisksImpact.create!([
  {id: 1, name: "Injury", impact: "Negligible", description: "Adverse event leading to minor injury not requiring first aid. <br /> No impaired Psychosocial functioning", value: 1},
  {id: 2, name: "Injury", impact: "Minor", description: "Minor injury or illness, first aid treatment required <br /> <3 days absence <br /> < 3 days extended hospital stay <br /> Impaired psychosocial functioning greater than 3 days less than one month", value: 2},
  {id: 3, name: "Injury", impact: "Moderate", description: "Significant injury requiring medical treatment e.g. Fracture and/or counselling. Agency reportable, e.g. HSA, Gardaí (violent and aggressive acts). >3 Days absence 3-8 Days extended hospital Stay Impaired psychosocial functioning greater than one month less than six months", value: 3},
  {id: 4, name: "Injury", impact: "Major", description: "Major injuries/long term incapacity or disability (loss of limb) requiring medical treatment and/or counselling Impaired psychosocial functioning greater than six months", value: 4},
  {id: 5, name: "Injury", impact: "Extreme", description: "Incident leading to death or major pe which impacts on large number of patients or member of the public  Permanent psychosocial  functioning incapacity.rmanent incapacity. Event", value: 5},
  {id: 6, name: "Service User Experience", impact: "Negligible", description: "Reduced quality of  service user experience related to inadequate  provision of information", value: 1},
  {id: 7, name: "Service User Experience", impact: "Minor", description: "Unsatisfactory  service user experience related to less than optimal treatment and/or inadequate information, not being to talked to & treated as an equal; or not being treated with honesty, dignity & respect - readily resolvable ", value: 2},
  {id: 8, name: "Service User Experience", impact: "Moderate", description: "Unsatisfactory service user experience related to less than optimal treatment resulting in short term effects (less than 1 week)", value: 3},
  {id: 9, name: "Service User Experience", impact: "Major", description: "Unsatisfactory service user experience related to poor treatment resulting in long term effects", value: 4},
  {id: 10, name: "Service User Experience", impact: "Extreme", description: "Totally unsatisfactory service user outcome resulting in long term effects, or extremely poor experience of care provision", value: 5},
  {id: 11, name: "Compliance with Standards (Statutory, Clinical, Professional & Management)", impact: "Negligible", description: "Minor non compliance with internal standards. Small number of minor issues requiring improvement ", value: 1},
  {id: 12, name: "Compliance with Standards (Statutory, Clinical, Professional & Management)", impact: "Minor", description: "Single failure to meet internal standards or follow protocol. Minor recommendations which can be easily addressed by local management", value: 2},
  {id: 13, name: "Compliance with Standards (Statutory, Clinical, Professional & Management)", impact: "Moderate", description: "Repeated failure to meet internal standards or follow protocols. Important recommendations that can be addressed with an appropriate management action plan. ", value: 3},
  {id: 14, name: "Compliance with Standards (Statutory, Clinical, Professional & Management)", impact: "Major", description: "Repeated failure to meet external standards. Failure to meet national norms and standards / Regulations (e.g. Mental Health, Child Care Act etc). Critical report or substantial number of significant findings and/or lack of adherence to regulations. ", value: 4},
  {id: 15, name: "Compliance with Standards (Statutory, Clinical, Professional & Management)", impact: "Extreme", description: "Gross failure to meet external standards Repeated failure to meet national norms and standards / regulations. Severely critical report with possible major reputational or financial implications. ", value: 5},
  {id: 16, name: "Objectives/Projects", impact: "Negligible", description: "Barely noticeable reduction in scope, quality or schedule.", value: 1},
  {id: 17, name: "Objectives/Projects", impact: "Minor", description: "Minor reduction in scope, quality or schedule.", value: 2},
  {id: 18, name: "Objectives/Projects", impact: "Moderate", description: "Reduction in scope or quality of project; project objectives or schedule.", value: 3},
  {id: 19, name: "Objectives/Projects", impact: "Major", description: "Significant project over – run.", value: 4},
  {id: 20, name: "Objectives/Projects", impact: "Extreme", description: "Inability to meet project objectives. Reputation of the organisation seriously damaged.", value: 5},
  {id: 21, name: "Business Continuity", impact: "Negligible", description: "Interruption in a service which does not impact on the delivery of service user care or the ability to continue to provide service.", value: 1},
  {id: 22, name: "Business Continuity", impact: "Minor", description: "Short term disruption to service with minor impact on service user care.", value: 2},
  {id: 23, name: "Business Continuity", impact: "Moderate", description: "Some disruption in service with unacceptable impact on service user care.       Temporary loss of ability to provide service", value: 3},
  {id: 24, name: "Business Continuity", impact: "Major", description: "Sustained loss of service which has serious impact on delivery of service user care or service resulting in major contingency plans being involved", value: 4},
  {id: 25, name: "Business Continuity", impact: "Extreme", description: "Permanent loss of core service or facility. Disruption to facility leading to significant ‘knock on’ effect ", value: 5},
  {id: 26, name: "Adverse publicity/ Reputation", impact: "Negligible", description: "Rumours, no media coverage. No public concerns voiced. Little effect on employees morale. No review/investigation necessary.", value: 1},
  {id: 27, name: "Adverse publicity/ Reputation", impact: "Minor", description: "Local media coverage – short term. Some public concern. Minor effect on employees morale / public attitudes. Internal review necessary.", value: 2},
  {id: 28, name: "Adverse publicity/ Reputation", impact: "Moderate", description: "Local media – adverse publicity. Significant effect on employees morale & public perception of the organisation. Public calls (at local level) for specific remedial actions. Comprehensive review/investigation necessary.", value: 3},
  {id: 29, name: "Adverse publicity/ Reputation", impact: "Major", description: "National media/ adverse publicity, less than 3 days. News stories & features in national papers. Local media – long term adverse publicity. Public confidence in the organisation undermined. HSE use of resources questioned. Minister may make comment. Possible questions in the Dáil. Public calls (at national level) for specific remedial actions to be taken possible HSE review/investigation", value: 4},
  {id: 30, name: "Adverse publicity/ Reputation", impact: "Extreme", description: "National/International media/ adverse publicity, > than 3 days. Editorial follows days of news stories & features in National papers. Public confidence in the organisation undermined. HSE use of resources questioned. CEO’s performance questioned. Calls for individual HSE officials to be sanctioned. Taoiseach/Minister forced to comment or intervene. Questions in the Dail. Public calls (at national level) for specific remedial actions to be taken. Court action. Public (independent) Inquiry. ", value: 5},
  {id: 31, name: "Financial Loss (per local Contact)", impact: "Negligible", description: "<€1k", value: 1},
  {id: 32, name: "Financial Loss (per local Contact)", impact: "Minor", description: "€1k – €10k", value: 2},
  {id: 33, name: "Financial Loss (per local Contact)", impact: "Moderate", description: "€10k – €100k", value: 3},
  {id: 34, name: "Financial Loss (per local Contact)", impact: "Major", description: "€100k – €1m", value: 4},
  {id: 35, name: "Financial Loss (per local Contact)", impact: "Extreme", description: ">€1m", value: 5},
  {id: 36, name: "Environment", impact: "Negligible", description: "Nuisance Release.", value: 1},
  {id: 37, name: "Environment", impact: "Minor", description: "On site release contained by organisation.", value: 2},
  {id: 38, name: "Environment", impact: "Moderate", description: "On site release contained by organisation.", value: 3},
  {id: 39, name: "Environment", impact: "Major", description: "Release affecting minimal off-site area requiring external assistance (fire brigade, radiation, protection service etc.)", value: 4},
  {id: 40, name: "Environment", impact: "Extreme", description: "Toxic release affecting off-site with detrimental effect requiring outside assistance.", value: 5},
  {id: 41, name: "", impact: "Negligible", description: "", value: 1},
  {id: 42, name: "", impact: "Minor", description: "", value: 2},
  {id: 43, name: "", impact: "Moderate", description: "", value: 3},
  {id: 44, name: "", impact: "Major", description: "", value: 4},
  {id: 45, name: "", impact: "Extreme", description: "", value: 5}
])
Service.create!([
  {id: 1, name: "Lipid screening services", description: "lipid screening serviceslipid screening services", enabled: true, sequence: 1},
  {id: 2, name: "Seasonal influenza vaccination", description: "seasonal influenza vaccination", enabled: true, sequence: 2},
  {id: 3, name: "A", description: "A", enabled: true, sequence: 3},
  {id: 4, name: "B", description: "B", enabled: true, sequence: 4},
  {id: 5, name: "C", description: "C", enabled: true, sequence: 5}
])
Topic.create!([
  {id: 4, name: "General", description: "General", status: 1, organisation_id: 1, score: nil, last_audit_date: nil},
  {id: 5, name: "Error/ Incident Management", description: "Error/ Incident Management", status: 1, organisation_id: 1, score: nil, last_audit_date: nil}
])
TopicService.create!([
  {id: 1, topic_id: 4, service_id: 1},
  {id: 2, topic_id: 4, service_id: 2},
  {id: 3, topic_id: 4, service_id: 3},
  {id: 4, topic_id: 4, service_id: 4},
  {id: 5, topic_id: 4, service_id: 5},
  {id: 6, topic_id: 5, service_id: 1},
  {id: 7, topic_id: 5, service_id: 5}
])
Trainee.create!([
  {id: 1, status: 1, document_id: 1, user_id: 1, major_version: 0, minor_version: 1},
  {id: 2, status: 1, document_id: 2, user_id: 1, major_version: 0, minor_version: 1}
])
