describe 'the subscription', ->
  beforeEach ->
    MeteorStubs.install()

  afterEach ->
    MeteorStubs.uninstall()

  it 'Articles should exist', ->
    expect(Articles).toBeDefined()

  it 'UserData should exist', ->
    expect(Meteor.users).toBeDefined
