;; Title: StacksDAO - Bitcoin-Compatible DAO Governance Framework
;;
;; Summary:
;; A decentralized autonomous organization (DAO) framework built on Stacks,
;; designed for Bitcoin compatibility with reputation-based governance,
;; secure treasury management, and cross-DAO collaboration capabilities.
;;
;; Description:
;; StacksDAO enables decentralized governance through a weighted voting mechanism
;; that combines reputation and stake. Members can create proposals, vote, and
;; collaborate with other DAOs. The contract includes security features like
;; reputation decay for inactive members and secure treasury management with
;; proper authorization controls.

;; Constants
(define-constant CONTRACT-OWNER tx-sender) ;; Immutable contract deployer
(define-constant PROPOSAL_LIFETIME u1440) ;; 10 days in blocks
(define-constant INACTIVITY_PERIOD u4320) ;; 30 days in blocks
(define-constant REPUTATION_BASE_UNIT u1) ;; Base governance weight

;; Error codes (Bitcoin-standard numeric codes)
(define-constant ERR-NOT-AUTHORIZED (err u100)) ;; 0x64
(define-constant ERR-ALREADY-MEMBER (err u101)) ;; 0x65
(define-constant ERR-NOT-MEMBER (err u102)) ;; 0x66
(define-constant ERR-INVALID-PROPOSAL (err u103))
(define-constant ERR-PROPOSAL-EXPIRED (err u104))
(define-constant ERR-ALREADY-VOTED (err u105))
(define-constant ERR-INSUFFICIENT-FUNDS (err u106))
(define-constant ERR-INVALID-AMOUNT (err u107))

;; Data Variables
(define-data-var total-members uint u0)
(define-data-var total-proposals uint u0)
(define-data-var treasury-balance uint u0)

;; Data Maps
(define-map members
  principal
  {
    reputation: uint,
    stake: uint,
    last-interaction: uint,
  }
)

(define-map proposals
  uint
  {
    creator: principal,
    title: (string-ascii 50),
    description: (string-utf8 500),
    amount: uint,
    yes-votes: uint,
    no-votes: uint,
    status: (string-ascii 10),
    created-at: uint,
    expires-at: uint,
  }
)

(define-map votes
  {
    proposal-id: uint,
    voter: principal,
  }
  bool
)

(define-map collaborations
  uint
  {
    partner-dao: principal,
    proposal-id: uint,
    status: (string-ascii 10),
  }
)