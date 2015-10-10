describe 'the subscription', ->
  beforeEach ->
    MeteorStubs.install()

  afterEach ->
    MeteorStubs.uninstall()

  it 'Articles should exist', ->
    expect(Articles).toBeDefined

  it 'UserData should exist', ->
    expect(Meteor.users).toBeDefined

describe 'calling the search', ->
  beforeEach ->
    MeteorStubs.install()

  afterEach ->
    MeteorStubs.uninstall()

  it('"" should return all the articles')
    expect(root.utils.search('')).toBe Articles.find({})

  it('undefind should return all the articles')
    expect(root.utils.search(undefind)).toBe Articles.find({})