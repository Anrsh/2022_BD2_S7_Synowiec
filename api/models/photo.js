const { Sequelize, DataTypes } = require('sequelize');



const sequelize = new Sequelize(process.env.PGLINK);


const Photo = sequelize.define('Photo', {
    id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        autoIncrement: true,
        primaryKey: true
    },
    // I am not so sure about that field, need to reconsider that
    owner: {
        type: DataTypes.STRING,
        allowNull: false
    },
    name: {
        type: DataTypes.STRING(32),
        allowNull: false
    },
    size: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    resolution: {
        type: DataTypes.STRING(10),
        allowNull: false
    },
    extension: {
        type: DataTypes.STRING(5),
        allowNull: false
    },
    galleries: {
        type: DataTypes.ARRAY(DataTypes.INTEGER),
        allowNull: false
    },
    photo_file: {
        type: DataTypes.BLOB,
        allowNull: false
    },

}, {
    timestamps: false
});

module.export = Photo;