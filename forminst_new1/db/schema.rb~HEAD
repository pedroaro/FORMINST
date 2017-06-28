# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170626120312) do

  create_table "actividad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tipo_actividad_id"
    t.text    "actividad",         limit: 4294967295
    t.boolean "anulada"
    t.index ["tipo_actividad_id"], name: "actividadTipoactividad", using: :btree
  end

  create_table "actividad_ejecutada", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text    "descripcion",          limit: 4294967295
    t.date    "fecha"
    t.boolean "actual"
    t.integer "informe_actividad_id"
    t.index ["informe_actividad_id"], name: "actividadejecutadaInformeactividad", using: :btree
  end

  create_table "adecuacion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "planformacion_id"
    t.integer "tutor_id"
    t.date    "fecha_modificacion"
    t.date    "fecha_creacion"
    t.string  "estado"
    t.index ["planformacion_id"], name: "adecuacionPlanformacion", using: :btree
    t.index ["tutor_id"], name: "adecuacionUsuario", using: :btree
  end

  create_table "adecuacion_actividad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "adecuacion_id"
    t.integer "actividad_id"
    t.boolean "anulada"
    t.integer "semestre"
    t.index ["actividad_id"], name: "adecuacionactividadActividad", using: :btree
    t.index ["adecuacion_id"], name: "adecuacionactividadAdecuacion", using: :btree
  end

  create_table "document", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents", limit: 16777215
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "instructor_id"
    t.integer  "tutor_id"
    t.integer  "adecuacion_id"
    t.integer  "informe_id"
    t.index ["adecuacion_id"], name: "documentadecuacion", using: :btree
    t.index ["informe_id"], name: "documentinforme", using: :btree
    t.index ["instructor_id"], name: "documentinstructor", using: :btree
    t.index ["tutor_id"], name: "documenttutor", using: :btree
  end

  create_table "documento", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_actividad_id"
    t.string  "archivo"
    t.index ["informe_actividad_id"], name: "documentoInformeactividad", using: :btree
  end

  create_table "documento_informe", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_id"
    t.string  "archivo"
    t.index ["informe_id"], name: "documentoInforme", using: :btree
  end

  create_table "documento_plan", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "planformacion_id"
    t.string  "archivo"
    t.index ["planformacion_id"], name: "documentoPlan", using: :btree
  end

  create_table "entidad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nombre"
  end

  create_table "escuela", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "nombre"
  end

  create_table "estatus_adecuacion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "adecuacion_id"
    t.date    "fecha"
    t.integer "estatus_id"
    t.boolean "actual"
    t.index ["adecuacion_id"], name: "estatusAdecuacionAdecuacion", using: :btree
    t.index ["estatus_id"], name: "estatusAdecuacionTipoEstatus", using: :btree
  end

  create_table "estatus_informe", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_id"
    t.date    "fecha"
    t.integer "estatus_id"
    t.boolean "actual"
    t.index ["estatus_id"], name: "estatus_informeTipoEstatus", using: :btree
    t.index ["informe_id"], name: "estatus_informeinforme", using: :btree
  end

  create_table "historial_actividad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "actividad_id",                          null: false
    t.text    "actividad",          limit: 4294967295, null: false
    t.date    "fecha_modificacion",                    null: false
    t.index ["actividad_id"], name: "historial_actividad_fk", using: :btree
  end

  create_table "historial_resultado", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "resultado_id",                          null: false
    t.text    "resultado",          limit: 4294967295, null: false
    t.date    "fecha_modificacion",                    null: false
    t.index ["resultado_id"], name: "historial_resultado_fk", using: :btree
  end

  create_table "informe", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "planformacion_id"
    t.integer "tutor_id"
    t.text    "opinion_tutor",      limit: 4294967295
    t.text    "conclusiones",       limit: 4294967295
    t.integer "numero"
    t.date    "fecha_creacion"
    t.string  "estado"
    t.date    "fecha_inicio"
    t.date    "fecha_fin"
    t.date    "fecha_modificacion"
    t.integer "tipo_id"
    t.index ["planformacion_id"], name: "informePlanFormacion", using: :btree
    t.index ["tipo_id"], name: "informetipo", using: :btree
    t.index ["tutor_id"], name: "informeusuario", using: :btree
  end

  create_table "informe_actividad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_id"
    t.integer "actividad_id"
    t.index ["actividad_id"], name: "informeActividadActividad", using: :btree
    t.index ["informe_id"], name: "informeActividadinforme", using: :btree
  end

  create_table "instructortutor", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "instructor_id"
    t.integer "tutor_id"
    t.integer "actual"
    t.date    "fecha_inicio"
    t.date    "fecha_fin"
    t.index ["instructor_id"], name: "instructortutorinstructorid", using: :btree
    t.index ["tutor_id"], name: "instructortutortutorid", using: :btree
  end

  create_table "notificacion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "instructor_id"
    t.integer "tutor_id"
    t.integer "adecuacion_id"
    t.integer "informe_id"
    t.integer "actual"
    t.text    "mensaje",       limit: 4294967295
    t.index ["adecuacion_id"], name: "notificacionadecuacion", using: :btree
    t.index ["informe_id"], name: "notificacioninforme", using: :btree
    t.index ["instructor_id"], name: "notificacioninstructor", using: :btree
    t.index ["tutor_id"], name: "notificaciontutor", using: :btree
  end

  create_table "observacion_actividad_adecuacion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "revision_id"
    t.integer "adecuacionactividad_id"
    t.text    "observaciones",          limit: 4294967295
    t.date    "fecha"
    t.integer "actual"
    t.index ["adecuacionactividad_id"], name: "observacionActividadAdecuacionActividad", using: :btree
    t.index ["revision_id"], name: "observacionActividadRevision", using: :btree
  end

  create_table "observacion_actividad_informe", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_actividad_id"
    t.integer "revision_id"
    t.text    "observaciones",        limit: 4294967295
    t.integer "actual"
    t.index ["informe_actividad_id"], name: "observacionActividadinformeinformeActividad", using: :btree
    t.index ["revision_id"], name: "observacionActividadinformeRevision", using: :btree
  end

  create_table "observacion_tutor", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_actividad_id"
    t.text    "observaciones",        limit: 4294967295
    t.date    "fecha"
    t.boolean "actual"
    t.index ["informe_actividad_id"], name: "observacionTutorinformeActividad", using: :btree
  end

  create_table "permiso", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "concepto"
  end

  create_table "permisologia", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "permiso_id"
    t.integer "usuario_id"
    t.string  "attribute"
    t.boolean "read"
    t.boolean "write"
    t.index ["permiso_id"], name: "permisologiaPermiso", using: :btree
    t.index ["usuario_id"], name: "permisologiaUsuario", using: :btree
  end

  create_table "persona", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "usuario_id"
    t.string  "nombres"
    t.string  "apellidos"
    t.date    "fecha_nacimiento"
    t.string  "ci"
    t.string  "telefono1"
    t.string  "telefono2"
    t.string  "direccion"
    t.string  "grado_instruccion"
    t.string  "area"
    t.string  "subarea"
    t.index ["usuario_id"], name: "personausuario", using: :btree
  end

  create_table "planformacion", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.date    "fecha_inicio"
    t.date    "fecha_fin"
    t.boolean "activo"
    t.integer "instructor_id"
    t.integer "tutor_id"
    t.date    "fecha_modificacion"
    t.string  "adscripcion_docencia"
    t.string  "adscripcion_investigacion"
    t.index ["instructor_id"], name: "PlanFormacionInstructor", using: :btree
    t.index ["tutor_id"], name: "PlanFormacionTutor", using: :btree
  end

  create_table "prorroga", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "planformacion_id"
    t.date    "fecha_aprobacion"
    t.integer "duracion"
    t.index ["planformacion_id"], name: "prorrogaPlanFormacion", using: :btree
  end

  create_table "respaldo", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "filename"
    t.string   "content_type"
    t.binary   "file_contents", limit: 16777215
    t.datetime "created_at",                     null: false
    t.integer  "version",                        null: false
    t.integer  "actual",                         null: false
    t.string   "estatus"
    t.integer  "instructor_id"
    t.integer  "tutor_id"
    t.integer  "adecuacion_id"
    t.integer  "informe_id"
    t.index ["adecuacion_id"], name: "respaldoadecuacion", using: :btree
    t.index ["informe_id"], name: "respaldoinforme", using: :btree
    t.index ["instructor_id"], name: "respaldoinstructor", using: :btree
    t.index ["tutor_id"], name: "respaldotutor", using: :btree
  end

  create_table "resultado", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_actividad_id"
    t.integer "tipo_resultado_id"
    t.text    "concepto",             limit: 4294967295
    t.string  "tipo_publicacion"
    t.string  "nombre_capitulo"
    t.string  "infoafiliaion"
    t.string  "cptipo"
    t.string  "nombre"
    t.string  "titulo"
    t.string  "autor"
    t.string  "autor_capitulo"
    t.integer "dia"
    t.string  "mes"
    t.integer "ano"
    t.string  "ciudad"
    t.string  "estado"
    t.string  "pais"
    t.string  "organizador"
    t.string  "duracion"
    t.string  "editor"
    t.string  "titulo_libro"
    t.string  "autor_libro"
    t.string  "nombre_revista"
    t.string  "nombre_periodico"
    t.string  "nombre_acto"
    t.string  "paginas"
    t.string  "nombre_paginaw"
    t.string  "sitio_paginaw"
    t.string  "url"
    t.string  "ISSN_impreso"
    t.string  "ISSN_electro"
    t.string  "volumen"
    t.string  "edicion"
    t.string  "DOI"
    t.string  "ISBN"
    t.string  "universidad"
    t.index ["informe_actividad_id"], name: "resultadoInformeActividad", using: :btree
    t.index ["tipo_resultado_id"], name: "resultadoTipoResultado", using: :btree
  end

  create_table "revision", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "informe_id"
    t.date    "fecha"
    t.integer "usuario_id"
    t.integer "adecuacion_id"
    t.integer "estatus_id"
    t.index ["adecuacion_id"], name: "revisionAdecuacion", using: :btree
    t.index ["estatus_id"], name: "revisionTipoEstatus", using: :btree
    t.index ["informe_id"], name: "revisioninforme", using: :btree
    t.index ["usuario_id"], name: "revisionusuario", using: :btree
  end

  create_table "session", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "session_id",               null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_session_on_session_id", unique: true, using: :btree
    t.index ["updated_at"], name: "index_session_on_updated_at", using: :btree
  end

  create_table "tipo_actividad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "concepto"
  end

  create_table "tipo_estatus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "concepto"
  end

  create_table "tipo_informe", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "tipo"
  end

  create_table "tipo_resultado", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "concepto", limit: 4294967295
  end

  create_table "usuario", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "user"
    t.boolean "ldap"
    t.boolean "activo"
    t.string  "password"
    t.string  "email"
    t.string  "tipo",     limit: 20
  end

  create_table "usuarioentidad", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "usuario_id"
    t.integer "entidad_id"
    t.integer "escuela_id"
    t.index ["entidad_id"], name: "usuarioEntidadEntidad", using: :btree
    t.index ["escuela_id"], name: "usuarioEscuela", using: :btree
    t.index ["usuario_id"], name: "usuarioEntidadUsuario", using: :btree
  end

  add_foreign_key "actividad", "tipo_actividad", name: "actividadTipoactividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "actividad_ejecutada", "informe_actividad", name: "actividadejecutadaInformeactividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "adecuacion", "planformacion", name: "adecuacionPlanformacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "adecuacion", "usuario", column: "tutor_id", name: "adecuacionUsuario", on_update: :cascade, on_delete: :cascade
  add_foreign_key "adecuacion_actividad", "actividad", name: "adecuacionactividadActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "adecuacion_actividad", "adecuacion", name: "adecuacionactividadAdecuacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "document", "adecuacion", name: "documentadecuacion"
  add_foreign_key "document", "informe", name: "documentinforme"
  add_foreign_key "document", "usuario", column: "instructor_id", name: "documentinstructor"
  add_foreign_key "document", "usuario", column: "tutor_id", name: "documenttutor"
  add_foreign_key "documento", "informe_actividad", name: "documentoInformeactividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documento_informe", "informe", name: "documentoInforme", on_update: :cascade, on_delete: :cascade
  add_foreign_key "documento_plan", "planformacion", name: "documentoPlan", on_update: :cascade, on_delete: :cascade
  add_foreign_key "estatus_adecuacion", "adecuacion", name: "estatusAdecuacionAdecuacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "estatus_adecuacion", "tipo_estatus", column: "estatus_id", name: "estatusAdecuacionTipoEstatus", on_update: :cascade, on_delete: :cascade
  add_foreign_key "estatus_informe", "informe", name: "estatus_informeinforme", on_update: :cascade, on_delete: :cascade
  add_foreign_key "estatus_informe", "tipo_estatus", column: "estatus_id", name: "estatus_informeTipoEstatus", on_update: :cascade, on_delete: :cascade
  add_foreign_key "historial_actividad", "actividad", name: "historial_actividad_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "historial_resultado", "resultado", name: "historial_resultado_fk", on_update: :cascade, on_delete: :cascade
  add_foreign_key "informe", "planformacion", name: "informePlanFormacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "informe", "tipo_informe", column: "tipo_id", name: "informetipo", on_update: :cascade, on_delete: :cascade
  add_foreign_key "informe", "usuario", column: "tutor_id", name: "informeusuario", on_update: :cascade, on_delete: :cascade
  add_foreign_key "informe_actividad", "actividad", name: "informeActividadActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "informe_actividad", "informe", name: "informeActividadinforme", on_update: :cascade, on_delete: :cascade
  add_foreign_key "instructortutor", "usuario", column: "instructor_id", name: "instructortutorinstructorid"
  add_foreign_key "instructortutor", "usuario", column: "tutor_id", name: "instructortutortutorid"
  add_foreign_key "notificacion", "adecuacion", name: "notificacionadecuacion"
  add_foreign_key "notificacion", "informe", name: "notificacioninforme"
  add_foreign_key "notificacion", "usuario", column: "instructor_id", name: "notificacioninstructor"
  add_foreign_key "notificacion", "usuario", column: "tutor_id", name: "notificaciontutor"
  add_foreign_key "observacion_actividad_adecuacion", "adecuacion_actividad", column: "adecuacionactividad_id", name: "observacionActividadAdecuacionActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "observacion_actividad_adecuacion", "revision", name: "observacionActividadRevision", on_update: :cascade, on_delete: :cascade
  add_foreign_key "observacion_actividad_informe", "informe_actividad", name: "observacionActividadinformeinformeActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "observacion_actividad_informe", "revision", name: "observacionActividadinformeRevision", on_update: :cascade, on_delete: :cascade
  add_foreign_key "observacion_tutor", "informe_actividad", name: "observacionTutorinformeActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "permisologia", "permiso", name: "permisologiaPermiso", on_update: :cascade, on_delete: :cascade
  add_foreign_key "permisologia", "usuario", name: "permisologiaUsuario", on_update: :cascade, on_delete: :cascade
  add_foreign_key "persona", "usuario", name: "personausuario", on_update: :cascade, on_delete: :cascade
  add_foreign_key "planformacion", "usuario", column: "instructor_id", name: "PlanFormacionInstructor", on_update: :cascade, on_delete: :cascade
  add_foreign_key "planformacion", "usuario", column: "tutor_id", name: "PlanFormacionTutor", on_update: :cascade, on_delete: :cascade
  add_foreign_key "prorroga", "planformacion", name: "prorrogaPlanFormacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "respaldo", "adecuacion", name: "respaldoadecuacion"
  add_foreign_key "respaldo", "informe", name: "respaldoinforme"
  add_foreign_key "respaldo", "usuario", column: "instructor_id", name: "respaldoinstructor"
  add_foreign_key "respaldo", "usuario", column: "tutor_id", name: "respaldotutor"
  add_foreign_key "resultado", "informe_actividad", name: "resultadoInformeActividad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "resultado", "tipo_resultado", name: "resultadoTipoResultado", on_update: :cascade, on_delete: :cascade
  add_foreign_key "revision", "adecuacion", name: "revisionAdecuacion", on_update: :cascade, on_delete: :cascade
  add_foreign_key "revision", "informe", name: "revisioninforme", on_update: :cascade, on_delete: :cascade
  add_foreign_key "revision", "tipo_estatus", column: "estatus_id", name: "revisionTipoEstatus", on_update: :cascade, on_delete: :cascade
  add_foreign_key "revision", "usuario", name: "revisionusuario", on_update: :cascade, on_delete: :cascade
  add_foreign_key "usuarioentidad", "entidad", name: "usuarioEntidadEntidad", on_update: :cascade, on_delete: :cascade
  add_foreign_key "usuarioentidad", "escuela", name: "usuarioEscuela"
  add_foreign_key "usuarioentidad", "usuario", name: "usuarioEntidadUsuario", on_update: :cascade, on_delete: :cascade
end
