/* eslint-disable comma-dangle */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-undef */
/* eslint-disable no-unused-vars */
const { expect } = require('chai');

describe('Token', async function () {
  let buyers, owner, Token, token;
  const NAME = 'Token';
  const SYMBOL = 'TKN';
  const INIT_SUPPLY = ethers.utils.parseEther('1000000');
  beforeEach(async function () {
    [buyers, owner] = await ethers.getSigners();
    Token = await ethers.getContractFactory('Token');
    token = await Token.connect(buyers).deploy(owner.address, INIT_SUPPLY);
    await token.deployed();
  });

  it(`Should have name ${NAME}`, async function () {
    expect(await token.name()).to.equal(NAME);
  });
  it(`Should have name ${SYMBOL}`, async function () {
    expect(await token.symbol()).to.equal(SYMBOL);
  });
  it(`Should have total supply ${INIT_SUPPLY.toString()}`, async function () {
    expect(await token.totalSupply()).to.equal(INIT_SUPPLY);
  });
  it(`Should mint initial supply ${INIT_SUPPLY.toString()} to owner`, async function () {
    expect(await token.balanceOf(owner.address)).to.equal(INIT_SUPPLY);
  });
});
