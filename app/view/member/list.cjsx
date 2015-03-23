React = require 'react'
{Input, Row, Col} = require 'react-bootstrap'
_ = require 'lodash'
Lazy = require 'lazy.js'
http = require 'superagent'

Select = require('react-select')
MemberDetail = require './detail'

# Member database.
memberIndex = {}

module.exports = React.createClass
  getInitialState: ->
    name: ''
    email: ''
    members: [] # Array Sequence of member objects.
    id: null
    selectedMember: null

  # handleNameChange: ->
  #   @setState name: @refs.name.getValue()

  handleSelect: (selectedVal) ->
    console.log 'selected', selectedVal
    selectedMember = memberIndex[parseInt(selectedVal)]
    newState =
      id: selectedVal
      selectedMember: selectedMember
    unless selectedMember.loaded
      @loadMember(selectedMember, true)
    @setState newState

  validationState: ->
    {name} = @state
    length = name.length;
    if (length > 10) then return 'success'
    else if (length > 5) then return 'warning'
    else if (length > 0) then return 'error'

  componentDidMount: ->
    http.get('/memberList.json').accept('json').end (err, res) =>
      console.log 'got member list'
      if not err and res and res.body
        @setState members: res.body
        memberIndex = _.indexBy res.body, 'id'
      else
        console.log err, res

  loadMember: (member, selected) ->
    {value, id} = member
    value = value or id
    id = id or parseInt(value)
    if not memberIndex[id]?.loading and not memberIndex[id]?.loaded
      memberIndex[id].loading = true
      console.log 'fetch', value
      http.get('/fetch/user/'+value).accept('json').end (err, res) =>
        if res and res.body and res.body.id
          res.body.loaded = true
          memberIndex[id] = res.body
          if selected is true
            console.log 'loaded selected member'
            @setState selectedMember: res.body
        else
          console.log err, res

  render: ->
    {data, query} = @props
    {name, members, id, selectedMember} = @state

    memberData = []
    # Search against name and emails.
    filterFunc = (opts, filterStr, currentVals) =>
      searchStrs = filterStr.toLowerCase().split(' ')
      search = (member) ->
        _.every searchStrs, (part) ->
          _.includes member.searchStr, part
      # Filter members.
      filteredOptions = Lazy(opts).filter(search).take(150).toArray()
      if filteredOptions.length < 6
        Lazy(filteredOptions).each(@loadMember)
      return filteredOptions

    options = _.map members, (row) ->
      {expired, title, emails} = row
      searchStr = title+' '+emails.join(', ')
      opt =
        #label: <span className={if expired then 'text-warning'}>{searchStr}</span>
        label: searchStr
        value: row.id+''
        searchStr: searchStr.toLowerCase()
    selectProps =
      name: 'form-field-name'
      placeholder: "Name or Email"
      options: options
      onChange: @handleSelect
      filterOptions: filterFunc
    if id
      selectProps.value = id
      if selectedMember
        memberDetails = <MemberDetail member={selectedMember} />
    selectInput = React.createElement(Select, selectProps)

    <div>
      {selectInput}
      {memberDetails}
    </div>
