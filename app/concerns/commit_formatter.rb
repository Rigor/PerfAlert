module CommitFormatter
  def format_commit(commit)
    commit['id'] = format_commit_id commit['id']
    commit
  end

  def format_commit_id(id)
    id[0..6] if id
  end
end
