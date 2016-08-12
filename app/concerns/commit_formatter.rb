module CommitFormatter
  def format_commit(commit)
    commit.tap { |c| c['id'] = format_commit_id(c['id']) if c }
  end

  def format_commit_id(id)
    id[0..6] if id
  end
end
