pragma solidity  >= 0.6.0;

contract Vote{

  // strucuture
  struct candidator{
    string name;
    uint upVote;
  }

  // variable
  bool live;
  address owner;
  candidator[] public candidatorList;

  // mapping
  mapping(address => bool) Voted;


  // event
  event AddCandidator(string name);
  event UpVote(string candidator, uint upVote);
  event FinishVote(bool live);
  event Voting(address owner);

  // modifier : 한정사 - 보트를 끝낼때 아무나 하면 안되기 때문에
  modifier onlyOwner {
    require(msg.sender == owner);
    _;
  }


  // constructor
  constructor() public {
    owner = msg.sender;
    live = true;

    emit Voting(owner);
  }


  // 함수 인자에는 보통 _언더바를 많이 붙임
  // candidator : 후보자
  function addCandidator(string memory _name) public onlyOwner{
    require(live == true);
    require(candidatorList.length < 5);
    candidatorList.push(candidator(_name, 0));

    //emit event - 추가했다는 것을 알리기 위한 문장
    emit AddCandidator(_name);
  }

  // voting : 투표
  function upVote(uint _indexOfCandidator) public {
    require(live == true);
    require(_indexOfCandidator < candidatorList.length);
    require(Voted[msg.sender] == false);

    candidatorList[_indexOfCandidator].upVote++;

    Voted[msg.sender] = true;

    emit UpVote(candidatorList[_indexOfCandidator].name, candidatorList[_indexOfCandidator].upVote);
  }

  // finish vote : 투표 끝내기
  function finishVote() public onlyOwner {
    require(live == true);
    live = false;

    emit FinishVote(live);
  }

}


