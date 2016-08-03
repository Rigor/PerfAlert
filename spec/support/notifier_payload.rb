module NotifierPayloads
  # This constant is used in messenger tests. It is a sample payload that is sent to each messenger for parsing.
  BASE = {
    commit_info: {
      'id'  => 'a0d514e1e6c8320d79576aa2ea8c8ecc040da701',
      'url' => 'https://github.com/Rigor/labs/commit/a0d514e1e6c8320d79576aa2ea8c8ecc040da701',
      'author_name' => 'Test User',
      'author_email' => 'test.user@rigor.com',
      'message' => 'wefv',
      'timestamp' => '2016-08-01T21:54:33Z'
    },
    score_result: 'Total defect count remained the same',
    comparison_url: 'https://optimization.rigor.com/c/224148/224148'
  }.freeze

  HIPCHAT = BASE.merge color: 'green'
  SLACK   = BASE.merge color: '#2ECC71'
end
