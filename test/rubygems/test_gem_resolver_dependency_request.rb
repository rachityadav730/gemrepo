# frozen_string_literal: true

require_relative "helper"

class TestGemResolverDependencyRequest < Gem::TestCase
  def test_development_eh
    a_dep = dep "a", ">= 1"

    a_dep_req = Gem::Resolver::DependencyRequest.new a_dep, nil

    refute a_dep_req.development?

    b_dep = dep "b", ">= 1", :development

    b_dep_req = Gem::Resolver::DependencyRequest.new b_dep, nil

    assert b_dep_req.development?
  end

  def test_match_eh
    spec = util_spec "a", 1
    dependency = dep "a", ">= 1"

    dr = Gem::Resolver::DependencyRequest.new dependency, nil

    assert dr.match? spec
  end

  def test_match_eh_prerelease
    spec = util_spec "a", "1.a"

    a_dep = dep "a", ">= 1"
    a_dr = Gem::Resolver::DependencyRequest.new a_dep, nil

    refute a_dr.match? spec

    a_pre_dep = dep "a", ">= 1.a"
    a_pre_dr = Gem::Resolver::DependencyRequest.new a_pre_dep, nil

    assert a_pre_dr.match? spec
  end

  def test_match_eh_prerelease_allow_prerelease
    spec = util_spec "a", "2.a"

    a_dep = dep "a", ">= 1"
    a_dr = Gem::Resolver::DependencyRequest.new a_dep, nil

    assert a_dr.match? spec, true
  end

  def test_matches_spec_eh
    spec = util_spec "a", 1
    dependency = dep "a", ">= 1"

    dr = Gem::Resolver::DependencyRequest.new dependency, nil

    assert dr.matches_spec? spec
  end

  def test_matches_spec_eh_prerelease
    spec = util_spec "a", "1.a"

    dependency = dep "a", ">= 0"
    dr = Gem::Resolver::DependencyRequest.new dependency, nil

    assert dr.matches_spec? spec
  end

  def test_requirement
    dependency = dep "a", ">= 1"

    dr = Gem::Resolver::DependencyRequest.new dependency, nil

    assert_equal dependency, dr.dependency
  end
end
