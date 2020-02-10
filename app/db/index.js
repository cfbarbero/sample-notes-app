const { Sequelize, Model, DataTypes } = require('sequelize');

// DB init
const sequelize = new Sequelize('postgres://devops_admin@db:5432/devops', {
  define: {
    paranoid: true,
    underscored: true,
    freezeTableName: true,
  },
});

// Models
class Member extends Model {}
Member.init({
  uuid: DataTypes.UUIDV4,
  first_name: DataTypes.STRING,
  last_name: DataTypes.STRING,
  email: DataTypes.STRING,
  ssn: DataTypes.STRING,
}, {
  sequelize,
  modelName: 'member',
});


class Note extends Model {}
Note.init({
  author_id: {
    type: DataTypes.INTEGER,
    references: {
      model: Member,
      key: 'id',
    },
  },
  content: DataTypes.STRING,
}, {
  sequelize,
  modelName: 'note',
});

sequelize.authenticate()
  .then(() => {
    Member.hasMany(Note, { foreignKey: 'author_id' });
    Note.belongsTo(Member, { foreignKey: 'author_id' });
  });

module.exports = sequelize;
