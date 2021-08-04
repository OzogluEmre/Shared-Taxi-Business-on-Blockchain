{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf600
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.24;\
contract b21427253\{\
    \
    mapping (address => bool) public participants;\
    address public manager;\
    address public taxi_driver;\
    uint public driver_balance;\
    address public car_dealer;\
    uint public car_no;\
    uint profit_per_participant;\
    uint public  contract_balance;\
    uint  public expenses;\
    uint  public participation_fee;\
    uint public  participants_size;\
    uint256 public CarID;\
    uint public history;\
    struct proposed_car\{\
        uint256 proposed_CarID;\
        uint price;\
        uint pro_validation_time;\
       \
    \}\
   proposed_car pro_car;\
    struct purchased_car\{\
        uint256 purchased_car_CarID;\
        uint price;\
        uint  purc_validation_time;\
        uint approval_state;\
        \
    \}\
    purchased_car purc_car;\
    constructor () public \{\
        manager=msg.sender;\
        contract_balance=0 ;\
        participants_size=0;\
        car_no=0;\
        driver_balance=0;\
        profit_per_participant=0;\
        expenses=10 ether;\
        participation_fee=100 ether;\
        \
    \}\
    function JoinFunction() public payable \{\
        \
        require(participants_size<=100);\
        require(msg.value>=100 ether);\
        contract_balance+=participation_fee;\
        manager.transfer(msg.value);\
        participants[msg.sender]=false;\
        participants_size++;\
        \
      \
      \
     \
    \}\
    function SetCarDealer(address _cardealer) public\{\
        require(msg.sender==manager);\
        car_dealer=_cardealer;\
\
    \}\
    //time parameter was declared as seconds \
    function CarPropose(uint256 carid,uint cprice,uint time) public \{\
        \
        require(msg.sender==car_dealer);\
        history=now;\
        pro_car.proposed_CarID=carid;\
        pro_car.price=cprice;\
        pro_car.pro_validation_time=time+history;\
    \
    \}\
    function PurchaseCar() public payable\{\
     require(msg.sender==manager);\
     if(pro_car.pro_validation_time-now>=0)\{\
        contract_balance-=pro_car.price;\
        car_dealer.send(msg.value);\
     \}\
     else\{\
         revert();\
     \}\
      \
    \}\
    function PurchasePropose() public \{\
        \
        require(msg.sender==car_dealer);\
        purc_car.purchased_car_CarID=pro_car.proposed_CarID;\
        purc_car.price=pro_car.price;\
        purc_car.purc_validation_time=pro_car.pro_validation_time;\
        purc_car.approval_state=0;\
    \
    \}\
    function ApproveSellProposal() public \{\
        if(participants[msg.sender]==false)\{\
            purc_car.approval_state++;\
            participants[msg.sender]=true;\
        \}\
        \
    \}\
    function SellCar() public payable\{\
        require(msg.sender==car_dealer);\
        if(purc_car.approval_state>participants_size/2 && pro_car.pro_validation_time-now >=0 )\{\
            contract_balance+=purc_car.price;\
            manager.transfer(msg.value);\
        \}\
        \
    \}\
    function SetDriver(address driver) public\{\
        require(msg.sender==manager);\
        taxi_driver=driver;\
    \}\
    function GetCharge() public payable\{\
        \
        contract_balance+=msg.value;\
    \}\
    uint driver_history=0;\
    function PaySalary() public payable \{\
        require(msg.sender==manager);\
        if(now-driver_history >=30 days )\{\
            driver_history=now;\
            driver_balance+=msg.value;\
            contract_balance-=msg.value;\
        \}\
        \
    \}\
    \
    function GetSalary() public payable \{\
        require(msg.sender==taxi_driver);\
        if(msg.value==driver_balance)\{\
            msg.sender.send(driver_balance);\
            driver_balance=0 ether;\
        \}\
    \}\
    uint dealer_history=0;\
    function CarExpenses() public payable\{\
        require(msg.sender==manager);\
         if(now-dealer_history >=180 days && msg.value==10 ether )\{\
            dealer_history=now;\
            car_dealer.send(msg.value);\
            contract_balance-=msg.value;\
        \}\
    \}\
    \
    uint participant_history=0;\
    function PayDividend() public\{\
        require(msg.sender==manager);\
        if(now-participant_history >=180 days )\{\
            participant_history=now;\
            profit_per_participant=contract_balance/participants_size;\
            contract_balance=0;\
        \}\
    \}\
    \
    function GetDividend() public payable\{\
        require(participants[msg.sender]==false,"Account is empty");\
        msg.sender.send(profit_per_participant);\
        participants[msg.sender]=true;\
        \
    \}\
    \
    \
\}}