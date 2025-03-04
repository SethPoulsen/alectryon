(*|
========================
 LaTeX formatting tests
========================

This files tests various aspects of the conversion to LaTeX, including spacing and formatting::

   alectryon latex_formatting.v --backend latex
     # Coq+reST → LaTeX; produces ‘latex_formatting.tex’

Long hypotheses
===============
|*)

From Coq Require List.
Import List.ListNotations.
Open Scope list_scope.

Section Long.
  Context {A B: Type}.

  Fixpoint map (l: list A)
           (f: forall (n: nat) (a: A)
                 (_in: List.nth_error l n = Some a), B)
           {struct l}
    : list B.
  Proof.
    pose proof f; pose map.
    destruct l.
    - exact nil.
    - refine (_ :: _).
      apply (f 0 a eq_refl).
      specialize (fun n => f (S n)).
      simpl in f.
      apply (map l f).
  Defined.
End Long.

Compute (map [11; 22; 33] (fun n a _ => (n, a * a))).


Definition t := True.
Definition ign {A} (_: A) := Prop.

(*|
.. role:: ltx(raw)
   :format: latex

:ltx:`\begin{small}`
|*)

Goal forall
    (a: ign (t -> t -> t -> t -> t -> t -> t))
    (aaa: ign (t -> t -> t -> t -> t -> t))
    (aaaaa: ign (t -> t -> t -> t -> t -> t))
    (aaaaaaa: ign (t -> t -> t -> t -> t))
    (aaaaaaaaa: ign (t -> t -> t -> t -> t))
    (aaaaaaaaaaa: ign (t -> t -> t -> t))
    (aaaaaaaaaaaaa: ign (t -> t -> t -> t))
    (aaaaaaaaaaaaaaa: ign (t -> t -> t))
    (aaaaaaaaaaaaaaaaa: ign (t -> t -> t))
    (aaaaaaaaaaaaaaaaaaa: ign (t -> t))
    (aaaaaaaaaaaaaaaaaaaaa: ign (t -> t))
    (aaaaaaaaaaaaaaaaaaaaaaa: ign t)
    (aaaaaaaaaaaaaaaaaaaaaaaaa: ign t),
    a -> aaa -> aaaaa -> aaaaaaa -> aaaaaaaaa ->
    aaaaaaaaaaa -> aaaaaaaaaaaaa -> aaaaaaaaaaaaaaa ->
    aaaaaaaaaaaaaaaaa -> aaaaaaaaaaaaaaaaaaa ->
    aaaaaaaaaaaaaaaaaaaaa -> aaaaaaaaaaaaaaaaaaaaaaa ->
    aaaaaaaaaaaaaaaaaaaaaaaaa -> True.
Proof. auto. Qed.

(*|
:ltx:`\end{small}`

Newlines
========
|*)

Require Import List.

Lemma skipn_app {A}:
  forall (l1 l2: list A) n,
    n <= List.length l1 ->
    skipn n (List.app l1 l2) =
    List.app (skipn n l1) l2.
Proof.
  induction l1.
  - destruct n. (* same line *)
    all: cbn.
    + reflexivity.
      Show Proof. (* .messages .unfold *)

      Check nat. (* .messages .unfold *)
    + inversion 1.
  - destruct n. cbn.
    + reflexivity.
    + intros. apply IHl1.
      Check le_S_n.
      apply le_S_n.
      match goal with
      | [ H: _ <= _ |- _ ] => simpl in H
      end.
      assumption.
Qed.

(* Some spacing tests: *)
(* ^ 0 lines *)

(* ^ 1 *)


(* ^ 2 *)



(* ^ 3 *)

(* ---
   ^ 0

   ^ 1


   ^ 2



   ^ 3 *)
