Feature: Manage vimpack git repo

  As a vimpack user
  I want manage my vimpack git repo
  So I can easily replicate my vimpack

  Scenario: Initialize vimpack git remote
    Given an initialized vimpack in "test_vimpack"
    When I run "vimpack git remote git@github.com:bramswenson/vimpack-repo.git"
    Then the exit status should be 0
      And the output should contain:
        """
         * adding remote origin
        remote origin added!
        """
      And the vimpack git remote "origin" should be "git@github.com:bramswenson/vimpack-repo.git"

  Scenario: Commit vimpack git repo with commit message
    Given an initialized vimpack in "test_vimpack"
      And I run "vimpack git remote git@github.com:bramswenson/vimpack-repo.git"
    When I run "vimpack git commit '[TEST] test commit'"
    Then the exit status should be 0
      And the output should contain:
        """
         * commiting vimpack repo
        commited: [TEST] test commit!
        """
      And the vimpack git commit logs last message should be "[TEST] test commit"

  Scenario: Commit vimpack git repo
    Given an initialized vimpack in "test_vimpack"
      And I run "vimpack git remote git@github.com:bramswenson/vimpack-repo.git"
    When I run "vimpack git commit"
    Then the exit status should be 0
      And the output should contain:
        """
         * commiting vimpack repo
        commited: [VIMPACK] vimpack updated!
        """
      And the vimpack git commit logs last message should be "[VIMPACK] vimpack updated"

  @wip
  Scenario: Push vimpack git repo
    Given an initialized vimpack in "test_vimpack"
      And I run "vimpack git remote git@github.com:bramswenson/vimpack-repo.git"
      And I run "vimpack git commit"
    When I run "vimpack git push"
    Then the exit status should be 0
      And the output should contain:
        """
         * pushing vimpack repo
        vimpack repo pushed!
        """
      And the vimpack git status should be empty
