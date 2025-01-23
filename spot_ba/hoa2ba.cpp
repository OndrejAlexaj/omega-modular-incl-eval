#include <iostream>
#include <spot/twa/twagraph.hh>
#include <spot/twaalgos/sbacc.hh>
#include <spot/twaalgos/split.hh>

#include <spot/parseaut/public.hh>
#include <spot/misc/version.hh>

void print_ba_format(std::ostream& out, spot::twa_graph_ptr aut)
{
  // The input should have Büchi acceptance.  Alternatively,
  // allow "t" acceptance since we can interpret this as a Büchi automaton
  // where all states are accepting.
  const spot::acc_cond& acc = aut->acc();
  if (!(acc.is_buchi() || acc.is_t()))
    throw std::runtime_error("unsupported acceptance condition");

  // The BA format only support state-based acceptance, so get rid
  // of transition-based acceptance if we have some.
  aut = spot::sbacc(aut);

  // We want one minterm per edge, as those will become letters
  aut = spot::split_edges(aut);

  out << aut->get_init_state_number() << '\n';
  for (auto& e: aut->edges())
    out << e.cond.id() << ',' << e.src << "->" << e.dst << '\n';

  unsigned ns = aut->num_states();
  for (unsigned s = 0; s < ns; ++s)
    if (acc.accepting(aut->state_acc_sets(s)))
       out << s << '\n';
}

int main(int argc, char **argv) {
  auto dict = spot::make_bdd_dict();
  spot::parsed_aut_ptr parsed_aut_A = nullptr;

  spot::automaton_stream_parser parser_A(argv[1]); // first filename provided as automaton A
  parsed_aut_A = parser_A.parse(dict);
  if (parsed_aut_A->format_errors(std::cerr)) { return EXIT_FAILURE; }
  spot::twa_graph_ptr aut_A = parsed_aut_A->aut;
  print_ba_format(std::cout, aut_A);
}