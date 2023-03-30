"use strict";

const firebase = require("../db");
const firestore = firebase.firestore();
const MenuResponse = require("../models/menu");

const insertMenu = async (req, res, next) => {
  try {
    const data = req.body;
    await firestore.collection("menus").doc().set(data);

    return res.status(201).json("Success!");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const getMenu = async (req, res, next) => {
  try {
    const menus = await firestore.collection("menus");
    const data = await menus.get();
    const menusArray = [];
    if (data.empty) {
      return res.status(404).json("No menu found");
    } else {
      data.forEach((doc) => {
        const menu = new MenuResponse(
          doc.id,
          doc.data().calories,
          doc.data().image,
          doc.data().name,
          doc.data().price,
          doc.data().quantity
        );
        menusArray.push(menu);
      });
      return res.status(200).json(menusArray);
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const deleteMenu = async (req, res, next) => {
  try {
    const id = req.params.id;
    await firestore.collection("menus").doc(id).delete();
    return res.status(200).json("Table deleted successfully");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const findMenu = async (req, res, next) => {
  try {
    const id = req.params.id;
    const menu = await firestore.collection("menus").doc(id);
    const data = await menu.get();
    if (!data.exists) {
      return res.status(404).json("Menu not found");
    } else {
      return res.status(200).json(data.data());
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const updateMenu = async (req, res, next) => {
  try {
    const id = req.params.id;
    const data = req.body;
    const menu = await firestore.collection("menus").doc(id);
    await menu.update(data);
    return res.status(200).json("Menu updated successfully");
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

const getMenuLimitCal = async (req, res, next) => {
  try {
    const menus = await firestore.collection("menus");
    const data = await menus.get();
    const menusArray = [];
    if (data.empty) {
      return res.status(404).json("No menu found");
    } else {
      data.forEach((doc) => {
        const menu = new MenuResponse(
          doc.id,
          doc.data().calories,
          doc.data().image,
          doc.data().name,
          doc.data().price,
          doc.data().quantity
        );
        if (menu.calories <= 700) {
          menusArray.push(menu);
        }
      });
      return res.status(200).json(menusArray);
    }
  } catch (err) {
    console.error(err);
    return res.status(400).json("bad request");
  }
};

module.exports = {
  InsertMenuService: insertMenu,
  UpdateMenuService: updateMenu,
  GetMenuService: getMenu,
  DeleteMenuService: deleteMenu,
  FindMenuService: findMenu,
  MenuLimitCalService: getMenuLimitCal,
};
