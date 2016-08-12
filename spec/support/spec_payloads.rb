module SpecPayloads
  # This constant is used in notifier specs. It is a sample payload that is sent to each messenger for parsing.
  BASE = {
    branch_name:      'spec_test',
    branch_url:       'https://example.com',
    project_name:     'perf_alert',
    project_hash_id:  '7600cbb1-215b-43ca-b15e-b9b8761bef83',
    build_url:        'https://example.com',
    build_number:      1,
    result:           'passed',
    event:            'deploy',
    started_at:       '2016-08-01T21:54:49Z',
    finished_at:      '2016-08-01T21:56:15Z',
    commit:  {
        'id' =>           'a0d514e1e6c8320d79576aa2ea8c8ecc040da701',
        'url' =>          'https://github.com/Rigor/labs/commit/a0d514e1e6c8320d79576aa2ea8c8ecc040da701',
        'author_name' =>  'Test User',
        'author_email' => 'test.user@example.com',
        'message' =>      'spec_test',
        'timestamp' =>    '2016-08-01T21:54:33Z'
    },
    score_result:     'Total defect count remained the same',
    comparison_url:   'https://optimization.rigor.com/c/224148/224148'
  }.freeze

  HIPCHAT = BASE.merge color: 'green'
  SLACK   = BASE.merge color: '#2ECC71'
end
