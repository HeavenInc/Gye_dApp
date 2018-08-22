const Owned = artifacts.require('./Ownable.sol');
const expectedExceptionPromise = require('./expectedException');

contract('Owned', (accounts) => {
  const owner = accounts[0];

  let owned;

  beforeEach( () => {
    return Owned.new({from:owner})
      .then( (instance) => {
        owned = instance;
      });
  });

  it('should be owned by "owner"', () => {
    return owned.owner({from:owner})
      .then( (_owner) => {
        assert.strictEqual(_owner, owner, "owned is not owned by 'owner'");
      });
  });

  it('Owner should be able to change owner', () => {
    const newOwner = accounts[1];
    return owned.changeOwner(newOwner, {from: owner})
    .then( tx => {
      return owned.owner({from:owner})
    })
    .then( _owner => {
      assert.strictEqual(_owner, newOwner, "owned is not owned by 'newOwner'");
    });
  });

  it('Only the Owner should be able to change owner', () => {
    const newOwner = accounts[1];
    return expectedExceptionPromise( () => {
      return owned.changeOwner(newOwner, {from: newOwner});
    }, 3000000);
  });
});
