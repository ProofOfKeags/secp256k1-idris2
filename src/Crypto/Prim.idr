module Crypto.Prim

cBind : String -> String
cBind fn = "C:\{fn},libsecp256k1"

CtxFlags : Type
CtxFlags = Bits32

data LCtx : Type where
data LScratch : Type where
data LPubkey : Type where

Ctx : Type
Ctx = Ptr LCtx

Scratch : Type
Scratch = Ptr LScratch

Pubkey : Type
Pubkey = AnyPtr

Seckey : Type
Seckey = AnyPtr

Signature : Type
Signature = AnyPtr

NonceFn : Type
NonceFn = AnyPtr -> AnyPtr -> AnyPtr -> AnyPtr -> AnyPtr -> Bits32 -> PrimIO Int

%foreign cBind "secp256k1_context_create"
prim__contextCreate : CtxFlags -> PrimIO Ctx

%foreign cBind "secp256k1_context_clone"
prim__contextClone : Ctx -> PrimIO Ctx

%foreign cBind "secp256k1_context_destroy"
prim__contextDestroy : Ctx -> PrimIO ()

%foreign cBind "secp256k1_context_set_illegal_callback"
prim__contextSetIllegalCallback : Ctx -> (String -> Ptr a -> PrimIO ()) -> Ptr a -> PrimIO ()

%foreign cBind "secp256k1_context_set_error_callback"
prim__contextSetErrorCallback : Ctx -> (String -> Ptr a -> PrimIO ()) -> Ptr a -> PrimIO ()

%foreign cBind "secp256k1_scratch_space_create"
prim__scratchSpaceCreate : Ctx -> Bits16 -> PrimIO Scratch

%foreign cBind "secp256k1_scratch_space_destroy"
prim__scratchSpaceDestroy : Ctx -> Scratch -> PrimIO ()

%foreign cBind "secp256k1_ec_pubkey_parse"
prim__ecPubkeyParse : Ctx -> Pubkey -> AnyPtr -> Bits16 -> PrimIO ()

%foreign cBind "secp256k1_ec_pubkey_serialize"
prim__ecPubkeySerialize : Ctx -> AnyPtr -> Ptr Bits16 -> Pubkey -> Bits32 -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_signature_parse_compact"
prim__ecdsaSignatureParseCompact : Ctx -> Signature -> AnyPtr -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_signature_parse_der"
prim__ecdsaSignatureParseDer : Ctx -> Signature -> AnyPtr -> Bits16 -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_signature_serialize_der"
prim__ecdsaSignatureSerializeDer : Ctx -> AnyPtr -> Ptr Bits16 -> Signature -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_signature_serialize_compact"
prim__ecdsaSignatureSerializeCompact : Ctx -> AnyPtr -> Signature -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_verify"
prim__ecdsaVerify : Ctx -> Signature -> AnyPtr -> Pubkey -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_signature_normalize"
prim__ecdsaSignatureNormalize : Ctx -> Signature -> Signature -> PrimIO Int

%foreign cBind "secp256k1_ecdsa_sign"
prim__ecdsaSign : Ctx -> Signature -> AnyPtr -> Seckey -> NonceFn -> AnyPtr -> PrimIO Int

%foreign cBind "secp256k1_ec_seckey_verify"
prim__ecSeckeyVerify : Ctx -> Seckey -> PrimIO Int

%foreign cBind "secp256k1_ec_pubkey_create"
prim__ecPubkeyCreate : Ctx -> Pubkey -> Seckey -> PrimIO Int

%foreign cBind "secp256k1_ec_seckey_negate"
prim__ecSeckeyNegate : Ctx -> Seckey -> PrimIO Int

%foreign cBind "secp256k1_ec_pubkey_negate"
prim__ecPubkeyNegate : Ctx -> Pubkey -> PrimIO Int

%foreign cBind "secp256k1_ec_seckey_tweak_add"
prim__ecSeckeyTweakAdd : Ctx -> Seckey -> AnyPtr -> PrimIO Int

%foreign cBind "secp256k1_ec_pubkey_tweak_add"
prim__ecPubkeyTweakAdd : Ctx -> Pubkey -> AnyPtr -> PrimIO Int

%foreign cBind "secp256k1_ec_seckey_tweak_mul"
prim__ecSeckeyTweakMul : Ctx -> Seckey -> Anyptr -> PrimIO Int

%foreign cBind "secp256k1_ec_pubkey_tweak_mul"
prim__ecPubkeyTweakMul : Ctx -> Pubkey -> Anyptr -> PrimIO Int

%foreign cBind "secp256k1_context_randomize"
prim__contextRandomize : Ctx -> AnyPtr -> PrimIO Int

%foreign cBind "secp256k1_ec_pubkey_combine"
prim__ecPubkeyCombine : Ctx -> Pubkey -> AnyPtr -> Bits16 -> PrimIO Int