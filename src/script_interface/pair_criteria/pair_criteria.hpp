/*
  Copyright (C) 2010,2011,2012,2013,2014 The ESPResSo project
  Copyright (C) 2002,2003,2004,2005,2006,2007,2008,2009,2010
  Max-Planck-Institute for Polymer Research, Theory Group

  This file is part of ESPResSo.

  ESPResSo is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  ESPResSo is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef SCRIPT_INTERFACE_PAIR_CRITERIA_PAIR_CRITERIA_HPP
#define SCRIPT_INTERFACE_PAIR_CRITERIA_PAIR_CRITERIA_HPP

#include "../auto_parameters/AutoParameters.hpp"
#include "core/pair_criteria.hpp"
#include <string>

namespace ScriptInterface {
namespace PairCriteria {

class PairCriterion : public AutoParameters {
public:
  PairCriterion() : m_c(new ::PairCriterion()) {};
  const std::string name() const {return "PairCriteria::PairCriterion";};
  virtual std::shared_ptr<::PairCriterion> pair_criterion() const  { return m_c; }
  virtual Variant call_method(std::string const &method,
                              VariantMap const &parameters) override {
      if (method == "decide") {
        return pair_criterion()->decide(
          boost::get<int>(parameters.at("id1")),
          boost::get<int>(parameters.at("id2")));
      }
      else
      {
        throw std::runtime_error("Unknown method called.");
      }
  } 
private:
  std::shared_ptr<::PairCriterion> m_c;
};

class DistanceCriterion : public PairCriterion {
public:
  DistanceCriterion() : m_c(new ::DistanceCriterion()) {
    add_parameters({
                    {"cut_off",
                     [this](Variant const &v) {
                       m_c->set_cut_off(get_value<double>(v));
                     },
                     [this]() { return m_c->get_cut_off(); }}});
  }

  const std::string name() const override { return "PairCriteria::DistanceCriterion"; }
  std::shared_ptr<::PairCriterion> pair_criterion() const override { return m_c; }

private:
  std::shared_ptr<::DistanceCriterion> m_c;
};

class EnergyCriterion : public PairCriterion {
public:
  EnergyCriterion() : m_c(new ::EnergyCriterion()) {
    add_parameters({
                    {"cut_off",
                     [this](Variant const &v) {
                       m_c->set_cut_off(get_value<double>(v));
                     },
                     [this]() { return m_c->get_cut_off(); }}});
  }

  const std::string name() const override { return "PairCriteria::EnergyCriterion"; }
  std::shared_ptr<::PairCriterion> pair_criterion() const override { return m_c; }

private:
  std::shared_ptr<::EnergyCriterion> m_c;
};

class BondCriterion : public PairCriterion {
public:
  BondCriterion() : m_c(new ::BondCriterion()) {
    add_parameters({
                    {"bond_type",
                     [this](Variant const &v) {
                       m_c->set_bond_type(get_value<int>(v));
                     },
                     [this]() { return m_c->get_bond_type(); }}});
  }

  const std::string name() const override { return "PairCriteria::BondCriterion"; }
  std::shared_ptr<::PairCriterion> pair_criterion() const override { return m_c; }

private:
  std::shared_ptr<::BondCriterion> m_c;
};

} /* namespace PairCriteria */
} /* namespace ScriptInterface */

#endif
