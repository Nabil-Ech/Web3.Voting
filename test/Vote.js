const { expect } = require("chai")
const { ethers } = require("hardhat")

const tokens = (n) => {
  return ethers.parseUnits(n.toString(), 'ether')
}

describe("Vote", function () {
  
  
  let vote
  beforeEach(async() => {
    [deployer, user1] = await ethers.getSigners()

    const Vote = await ethers.getContractFactory("Vote")
    vote = await Vote.deploy("test", "test")

    const transaction = await vote.connect(deployer).create_club("Mercedes", tokens(1))
    await transaction.wait()
  })
  describe("Deployment", () => {
    it ("sets the name", async() => {
      let result = await vote.name()
      expect(result).to.equal("test")
    })
  
    it ("sets the symbol", async() => {
      let result = await vote.symbol()
      expect(result).to.equal("test")
    })
  
    it ("sets the voter", async() => {
      let result = await vote.voter()
      expect(result).to.equal(deployer.address)
    })
  })

  describe("creating channels", () => {

    it ("Returns total channels", async() => {
      let result = await vote.totalchannels()
      expect(result).to.equal(1)
    })

    it ("Returns channel attributes", async() => {
      const channel = await vote.getChannel(1)
      expect(channel.id).to.equal(1)
      expect(channel.name).to.equal("Mercedes")
      expect(channel.cost).to.equal(tokens(1))
    })
  })
  
})